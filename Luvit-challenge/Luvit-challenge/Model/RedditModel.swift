//
//  RedditModel.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 02/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import Foundation

// MARK: - RedditPost
struct RedditPost : Decodable{
    var kind: String?
    var data: RedditPostData?
}

// MARK: - RedditPostData
struct RedditPostData : Decodable {
    var modhash: String?
    var dist: Int?
    var children: [Child]?
    var after: String?
    var before: String?
}

// MARK: - Child
struct Child : Decodable {
    var kind: String?
    var data: ChildData?
}

// MARK: - ChildData
struct ChildData : Decodable {
    var subreddit: String?
    var selftext: String?
    var authorFullname: String?
    var saved: Bool?
    var gilded: Int?
    var clicked: Bool?
    var title: String?
    var subredditNamePrefixed: String?
    var hidden: Bool?
    var pwls: Int?
    var linkFlairCSSClass: String?
    var downs: Int?
    var thumbnailHeight: Int?
    var hideScore: Bool?
    var name: String?
    var quarantine: Bool?
    var linkFlairTextColor: String?
    var upvoteRatio: Double?
    var subredditType: String?
    var ups: Int?
    var totalAwardsReceived: Int?
    var mediaEmbed: MediaEmbed?
    var thumbnailWidth: Int?
    var isOriginalContent: Bool?
    var isRedditMediaDomain: Bool?
    var isMeta: Bool?
    var secureMediaEmbed: MediaEmbed?
    var linkFlairText: String?
    var canModPost: Bool?
    var score: Int?
    var authorPremium: Bool?
    var thumbnail: String?
    var edited: Bool?
    var gildings: Gildings?
    var postHint: String?
    var isSelf: Bool?
    var created: Int?
    var linkFlairType: String?
    var wls: Int?
    var authorFlairType: String?
    var domain: String?
    var allowLiveComments: Bool?
    var archived: Bool?
    var noFollow: Bool?
    var isCrosspostable: Bool?
    var pinned: Bool?
    var over18: Bool?
    var preview: Preview?
    var allAwardings: [AllAwarding]?
    var mediaOnly: Bool?
    var canGild: Bool?
    var spoiler: Bool?
    var locked: Bool?
    var visited: Bool?
    var subredditID: String?
    var linkFlairBackgroundColor: String?
    var id: String?
    var isRobotIndexable: Bool?
    var author: String?
    var numComments: Int?
    var sendReplies: Bool?
    var whitelistStatus: String?
    var contestMode: Bool?
    var authorPatreonFlair: Bool?
    var permalink: String?
    var parentWhitelistStatus: String?
    var stickied: Bool?
    var url: String?
    var subredditSubscribers: Int?
    var createdUTC: Int?
    var numCrossposts: Int?
    var isVideo: Bool?
}

// MARK: - AllAwarding
struct AllAwarding : Decodable {
    var isNew: Bool?
    var daysOfDripExtension: Int?
    var coinPrice: Int?
    var id: String?
    var coinReward: Int?
    var iconURL: String?
    var daysOfPremium: Int?
    var iconHeight: Int?
    var resizedIcons: [ResizedIcon]?
    var iconWidth: Int?
    var isEnabled: Bool?
    var allAwardingDescription: String?
    var subredditCoinReward: Int?
    var count: Int?
    var name: String?
    var awardSubType: String?
    var awardType: String?
}

// MARK: - ResizedIcon
struct ResizedIcon : Decodable {
    var url: String?
    var width: Int?
    var height: Int?
}

// MARK: - Gildings
struct Gildings : Decodable  {
    var gid1: Int?
    var gid2: Int?
    var gid3: Int?
}

// MARK: - MediaEmbed
struct MediaEmbed : Decodable { }

// MARK: - Preview
struct Preview : Decodable {
    var images: [Image]?
    var redditVideoPreview: RedditVideoPreview?
    var enabled: Bool?
}

// MARK: - Image
struct Image : Decodable{
    var source: Source?
    var resolutions: [Source]?
    var variants: MediaEmbed?
    var id: String?
}

// MARK: - Source
struct Source : Decodable {
    var url: String?
    var width: Int?
    var height: Int?
}

// MARK: - RedditVideoPreview
struct RedditVideoPreview : Decodable {
    var fallbackURL: String?
    var height: Int?
    var width: Int?
    var scrubberMediaURL: String?
    var dashURL: String?
    var duration: Int?
    var hlsURL: String?
    var isGIF: Bool?
    var transcodingStatus: String?
}
