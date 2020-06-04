//
//  UICollectionView+Extensions.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 03/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit

extension UICollectionView {
    func setLoading() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .gray
        spinner.startAnimating()
        self.backgroundView = spinner
    }
    
    func restore() {
        self.backgroundView = nil
    }
}


