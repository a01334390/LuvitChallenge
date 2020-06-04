//
//  VRedditCollectionViewCell.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 03/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit

class VRedditCollectionViewCell: UICollectionViewCell {

    
    // MARK: - UI Elements
    @IBOutlet weak var lTitle: UILabel!
    @IBOutlet weak var iThumbnail: UIImageView!
    @IBOutlet weak var lAuthor: UILabel!
    @IBOutlet weak var lDatetime: UILabel!
    @IBOutlet weak var lComments: UILabel!
    
    // MARK: - Passed down configuration
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
        self.iThumbnail.layer.cornerRadius = 15
    }

}

// MARK: - Cell configurator

extension VRedditCollectionViewCell: PostConfigurator {
    func configure(with post: Child) {
        guard let cPost = post.data else {
            logger(message: "Post is not available.")
            return
        }
        
        //MARK: - Title setup
        if let sTitle = cPost.title {
            self.lTitle.text = sTitle
        }
        
        // MARK: - Author setup
        if let sAuthor = cPost.author {
            self.lAuthor.text = "u/\(sAuthor)"
        }
        
        //MARK: - Time ago
        
        if let postedDate = cPost.created {
            let date = Date(timeIntervalSince1970: Double(postedDate))
            self.lDatetime.text = date.timeAgoDisplay()
        }
        
        //MARK: - Comments
        
        if let commentNO = cPost.numComments {
            self.lComments.text = "\(commentNO) comments."
        } else {
            self.lComments.text = "0 comments."
        }
        
        // MARK: - Thumbnail Setup
        if let sThumbnailURL = cPost.thumbnail {
            NetworkController.shared().downloadImage(from: sThumbnailURL) { [weak self] thumbnail in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.iThumbnail.image = thumbnail
                }
            }
        }
    }
}

// MARK: - Convenience protocol

extension VRedditCollectionViewCell: LoggableClass {
    func logger(message: String) {
        print("[Reddit Cell] - \(message)")
    }
}
