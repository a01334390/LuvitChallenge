//
//  RedditFeedController.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 02/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit

enum LoadStatus {
    case ready (nextSlice: String)
    case loading (slice: String)
    case parseError
    case done
}

class RedditFeed {
    var redditPosts: [RedditPostData] = [RedditPostData]()
    var postLimit: Int = 10
    var after: String = ""
    var baseURL: String = "https://www.reddit.com/r/all/top/.json?t=all&limit="
    var loadStatus = LoadStatus.ready(nextSlice: "")
    
    init() {
        loadMorePosts()
    }
    
    func buildURL(withSlice slice: String) -> String {
        let sPostLimit: String = String(postLimit)
        let sURL: String = "\(baseURL)\(sPostLimit)"
        
        return slice.isEmpty ? sURL : "\(sURL)&after=\(after)"
    }
    
    func loadMorePosts(currentSlice: String? = nil) {
        guard case let .ready(slice) = loadStatus else {
            return
        }
        
        loadStatus = .loading(slice: "")
        let completeURL = self.buildURL(withSlice: slice)
    }
    
}
