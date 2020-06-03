//
//  ViewController.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 02/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Properties
    var collectionView: UICollectionView!
    let redditFeed : RedditFeed = RedditFeed()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializeCollectionView()
        self.registerCells()
    }
    
    // MARK: - Initializers
    private func initializeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        self.logger(message: "Collection View Initialized")
    }
    
    private func registerCells() {
        collectionView.register(RedditPostCollectionViewCell.self, forCellWithReuseIdentifier: "RedditPostCollectionViewCell")
        self.logger(message: "Cells successfully registered")
    }
    
    // MARK: - Collection View Delegate Methods
    
}


// MARK: - Collection View Datasource Methods

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RedditPostCollectionViewCell", for: indexPath) as! RedditPostCollectionViewCell
        return cell
    }
}

// MARK: - Collection View Flow Layout Methods

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 100)
    }
}

// MARK: - Convenience Protocol Methods

extension ViewController : LoggableClass {
    func logger(message: String) {
        print("[View Controller] - \(message)")
    }
}
