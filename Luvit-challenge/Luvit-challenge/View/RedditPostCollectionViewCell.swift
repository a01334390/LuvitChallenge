//
//  RedditPostCollectionViewCell.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 02/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit

class RedditPostCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        #if DEBUG
        self.backgroundColor = .cyan
        #endif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        
    }
}
