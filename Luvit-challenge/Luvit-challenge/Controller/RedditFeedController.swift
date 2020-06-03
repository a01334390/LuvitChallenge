//
//  RedditFeedController.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 02/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit

class RedditFeed : LoggableClass {
    
    //MARK: - Properties
    
    var redditPosts: [Child] = [Child]()
    private var postLimit: Int = 10
    private var afterHash: String = ""
    private var baseURL: String = "https://www.reddit.com/r/all/top/.json?t=all&limit="

    // MARK: Initializers
    
    init() {
        loadMorePosts()
    }
    
    // MARK: - Loading Functions
    
    /**
     Loads more posts from the Reddit API
     - Note: All logic regarding pagination is handled by the class. No parameters are required.
     */
    func loadMorePosts() {
        let completeURL = self.buildURL(withSlice: afterHash)
        guard let url = URL(string: completeURL), UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url,completionHandler: parsePostsFromResponse(data:response:error:))
        task.resume()
    }
    
    /**
     Parses the post response from the URL Session
     - Parameters:
        - data: Downloaded data from the URL Session (if any)
        - response: The URLResponse from the URL Session (if any)
        - error: Error object from the URLResponse (if any)
     */
    private func parsePostsFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            self.logger(message: "An error occurred while loading: \(error?.localizedDescription ?? "Unknown")")
            return
        }
        
        guard let data = data else {
            self.logger(message: "Data might be corrupted")
            return
        }
        
        let children: [Child] = parsePosts(from: data)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.redditPosts.append(contentsOf: children)
        }
    }
    
    /**
     Parses data from the URLSession into usable [Child] Objects
     - Parameter from: Data from the URL Session to be transformed into [Child] Objects
     - Returns: An array of child objects
     */
    private func parsePosts(from data: Data) -> [Child] {
        var response : RedditPost
        do {
            response = try JSONDecoder().decode(RedditPost.self, from: data)
        } catch {
            self.logger(message: error.localizedDescription)
            return []
        }
        return stripPostData(from: response)
    }
    
    /**
     Uses the parsed response to retrieve usable information regarding the posts and future API Calls.
    - Parameter redditPosts: [RedditPost] response parsed from the API
    - Returns: An array of child objects
    */
    private func stripPostData(from redditPost: RedditPost) -> [Child] {
        guard let rData = redditPost.data else {
            logger(message: "Response is empty.")
            return []
        }
        
        if let after = rData.after {
            self.afterHash = after
        }
        
        guard let children = rData.children else {
            logger(message: "Response returned no children.")
            return []
        }
        
        return children
    }
    
    // MARK: - Helpers
    
    /**
     Simple logging function
     - Parameter message: Message to be printed by this class
     */
    func logger(message: String) {
        print("[Reddit Controller] - \(message)")
    }
    
    /**
     Builds an URL from the base URL and passes the required parameters for the petition
     - Parameter slice: The slice of data to be loaded (retrieved from the API response)
     - Returns: A string URL
     */
    private func buildURL(withSlice slice: String) -> String {
        let sPostLimit: String = String(postLimit)
        let sURL: String = "\(baseURL)\(sPostLimit)"
        
        return slice.isEmpty ? sURL : "\(sURL)&after=\(afterHash)"
    }
}
