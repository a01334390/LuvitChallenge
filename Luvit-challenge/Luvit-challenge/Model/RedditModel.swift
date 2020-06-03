//
//  RedditModel.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 02/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import Foundation

// MARK: - RedditPost
struct RedditPost {
    let kind: String?
    let data: RedditPostData?
}

// MARK: - RedditPostData
struct RedditPostData {
    let modhash: String?
    let dist: Int?
    let children: [Child]?
    let after: String?
    let before: NSNull?
}

// MARK: - Child
struct Child {
    let kind: String?
    let data: ChildData?
}

// MARK: - ChildData
struct ChildData {
    let approvedAtUTC: NSNull?
    let subreddit, selftext, authorFullname: String?
    let saved: Bool?
    let modReasonTitle: NSNull?
    let gilded: Int?
    let clicked: Bool?
    let title: String?
    let linkFlairRichtext: [Any?]?
    let subredditNamePrefixed: String?
    let hidden: Bool?
    let pwls: Int?
    let linkFlairCSSClass: String?
    let downs, thumbnailHeight: Int?
    let topAwardedType: NSNull?
    let hideScore: Bool?
    let name: String?
    let quarantine: Bool?
    let linkFlairTextColor: String?
    let upvoteRatio: Double?
    let authorFlairBackgroundColor: NSNull?
    let subredditType: String?
    let ups, totalAwardsReceived: Int?
    let mediaEmbed: MediaEmbed?
    let thumbnailWidth: Int?
    let authorFlairTemplateID: NSNull?
    let isOriginalContent: Bool?
    let userReports: [Any?]?
    let secureMedia: NSNull?
    let isRedditMediaDomain, isMeta: Bool?
    let category: NSNull?
    let secureMediaEmbed: MediaEmbed?
    let linkFlairText: String?
    let canModPost: Bool?
    let score: Int?
    let approvedBy: NSNull?
    let authorPremium: Bool?
    let thumbnail: String?
    let edited: Bool?
    let authorFlairCSSClass: NSNull?
    let authorFlairRichtext: [Any?]?
    let gildings: Gildings?
    let postHint: String?
    let contentCategories: NSNull?
    let isSelf: Bool?
    let modNote: NSNull?
    let created: Int?
    let linkFlairType: String?
    let wls: Int?
    let removedByCategory, bannedBy: NSNull?
    let authorFlairType, domain: String?
    let allowLiveComments: Bool?
    let selftextHTML, likes, suggestedSort, bannedAtUTC: NSNull?
    let viewCount: NSNull?
    let archived, noFollow, isCrosspostable, pinned: Bool?
    let over18: Bool?
    let preview: Preview?
    let allAwardings: [AllAwarding]?
    let awarders: [Any?]?
    let mediaOnly, canGild, spoiler, locked: Bool?
    let authorFlairText: NSNull?
    let treatmentTags: [Any?]?
    let visited: Bool?
    let removedBy, numReports, distinguished: NSNull?
    let subredditID: String?
    let modReasonBy, removalReason: NSNull?
    let linkFlairBackgroundColor, id: String?
    let isRobotIndexable: Bool?
    let reportReasons: NSNull?
    let author: String?
    let discussionType: NSNull?
    let numComments: Int?
    let sendReplies: Bool?
    let whitelistStatus: String?
    let contestMode: Bool?
    let modReports: [Any?]?
    let authorPatreonFlair: Bool?
    let authorFlairTextColor: NSNull?
    let permalink, parentWhitelistStatus: String?
    let stickied: Bool?
    let url: String?
    let subredditSubscribers, createdUTC, numCrossposts: Int?
    let media: NSNull?
    let isVideo: Bool?
}

// MARK: - AllAwarding
struct AllAwarding {
    let giverCoinReward, subredditID: NSNull?
    let isNew: Bool?
    let daysOfDripExtension, coinPrice: Int?
    let id: String?
    let pennyDonate: NSNull?
    let coinReward: Int?
    let iconURL: String?
    let daysOfPremium, iconHeight: Int?
    let resizedIcons: [ResizedIcon]?
    let iconWidth: Int?
    let startDate: NSNull?
    let isEnabled: Bool?
    let allAwardingDescription: String?
    let endDate: NSNull?
    let subredditCoinReward, count: Int?
    let name: String?
    let iconFormat: NSNull?
    let awardSubType: String?
    let pennyPrice: NSNull?
    let awardType: String?
}

// MARK: - ResizedIcon
struct ResizedIcon {
    let url: String?
    let width, height: Int?
}

// MARK: - Gildings
struct Gildings {
    let gid1, gid2, gid3: Int?
}

// MARK: - MediaEmbed
struct MediaEmbed {
}

// MARK: - Preview
struct Preview {
    let images: [Image]?
    let redditVideoPreview: RedditVideoPreview?
    let enabled: Bool?
}

// MARK: - Image
struct Image {
    let source: ResizedIcon?
    let resolutions: [ResizedIcon]?
    let variants: MediaEmbed?
    let id: String?
}

// MARK: - RedditVideoPreview
struct RedditVideoPreview {
    let fallbackURL: String?
    let height, width: Int?
    let scrubberMediaURL: String?
    let dashURL: String?
    let duration: Int?
    let hlsURL: String?
    let isGIF: Bool?
    let transcodingStatus: String?
}
