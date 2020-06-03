//
//  RedditFeedController.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 02/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit

protocol LoggableClass {
    func logger(message: String)
}

class RedditFeed : LoggableClass {
    var redditPosts: [Child] = [Child]()
    var postLimit: Int = 10
    var afterHash: String = ""
    var baseURL: String = "https://www.reddit.com/r/all/top/.json?t=all&limit="

    
    init() {
        loadMorePosts()
    }
    
    func logger(message: String) {
        print("[Reddit Controller] - \(message)")
    }
    
    func buildURL(withSlice slice: String) -> String {
        let sPostLimit: String = String(postLimit)
        let sURL: String = "\(baseURL)\(sPostLimit)"
        
        return slice.isEmpty ? sURL : "\(sURL)&after=\(afterHash)"
    }
    
    func loadMorePosts() {
        
        let completeURL = self.buildURL(withSlice: afterHash)
        guard let url = URL(string: completeURL), UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url,completionHandler: parsePostsFromResponse(data:response:error:))
        task.resume()
    }
    
    func parsePostsFromResponse(data: Data?, response: URLResponse?, error: Error?) {
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
    
    func parsePosts(from data: Data) -> [Child] {
        var response : RedditPost
        do {
            response = try JSONDecoder().decode(RedditPost.self, from: data)
        } catch {
            self.logger(message: error.localizedDescription)
            return []
        }
        return stripPostData(from: response)
    }
    
    func stripPostData(from redditPost: RedditPost) -> [Child] {
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
}
