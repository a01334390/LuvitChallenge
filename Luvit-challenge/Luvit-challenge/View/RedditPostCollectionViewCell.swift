//
//  RedditPostCollectionViewCell.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 02/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit

class RedditPostCollectionViewCell: UICollectionViewCell {
    
    var postData: Child?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        #if DEBUG
        self.backgroundColor = .cyan
        self.layer.cornerRadius = 10
        #endif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        
    }
}

extension RedditPostCollectionViewCell : PostConfigurator {
    func configure(with post: Child) {
        
    }
}

extension RedditPostCollectionViewCell : LoggableClass {
    func logger(message: String) {
        print("[Reddit Cell] - \(message)")
    }
}
