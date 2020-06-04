//
//  RedditPostCollectionViewCell.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 02/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit

class RedditPostCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Child data
    private var postData: Child?
    
    // MARK: - Visual Properties
    var lTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private var lAuthor: UILabel?
    private var Ithumbnail : UIImageView?
    private var lNumberOfComents: UILabel?
    private var lUnreadStatus: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        #if DEBUG
        self.backgroundColor = .cyan
        #endif
        // MARK: - View Layout
        self.layer.cornerRadius = 10
        // MARK: - Thumbnail Layout
        Ithumbnail = UIImageView(frame: CGRect(x: 5, y: self.center.y, width: 100, height: 100))
        self.addSubview(Ithumbnail!)
        // MARK: - Title setup
        self.addSubview(lTitle)
        lTitle.frame = CGRect(x: Ithumbnail!.frame.size.width + 5,
                              y: self.center.y,
                              width: 300,
                              height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension RedditPostCollectionViewCell : PostConfigurator {
    func configure(with post: Child) {
        guard let cPost = post.data else {
            logger(message: "Post is not available.")
            return
        }
        
        // MARK: - Thumbnail Setup
        if let sThumbnailURL = cPost.thumbnail {
            NetworkController.shared().downloadImage(from: sThumbnailURL) { [weak self] thumbnail in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.Ithumbnail?.image = thumbnail
                }
            }
        }
    }
}

extension RedditPostCollectionViewCell : LoggableClass {
    func logger(message: String) {
        print("[Reddit Cell] - \(message)")
    }
}
