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
    var refreshControl:UIRefreshControl!
    let redditFeed : RedditFeed = RedditFeed()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        redditFeed.delegate = self
        self.initializeCollectionView()
        self.initializeRefreshControl()
        self.registerCells()
    }
    
    // MARK: - Initializers
    private func initializeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        self.logger(message: "Collection View Initialized")
    }
    
    private func initializeRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.collectionView.refreshControl = refreshControl
        self.collectionView.alwaysBounceVertical = true
    }
    
    @objc func refresh() {
        self.redditFeed.restore()
    }
    
    private func registerCells() {
        collectionView.register(RedditPostCollectionViewCell.self, forCellWithReuseIdentifier: "RedditPostCollectionViewCell")
        self.logger(message: "Cells successfully registered")
    }
    
    // MARK: - Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (redditFeed.redditPosts.count - 10) < indexPath.row {
            self.logger(message: "Will load more posts...")
            self.redditFeed.loadMorePosts()
        }
    }
    
}


// MARK: - Collection View Datasource Methods

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if redditFeed.redditPosts.count == 0 {
            self.collectionView.setLoading()
        } else {
            self.collectionView.restore()
        }
        return redditFeed.redditPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RedditPostCollectionViewCell", for: indexPath) as! RedditPostCollectionViewCell
        cell.configure(with: redditFeed.redditPosts[indexPath.row])
        return cell
    }
}

// MARK: - Collection View Flow Layout Methods

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 20, height: 500)
    }
}

// MARK: - Convenience Protocol Methods

extension ViewController : LoggableClass {
    func logger(message: String) {
        print("[View Controller] - \(message)")
    }
}

// MARK: - Convenience protocol

extension ViewController : RedditFeedDelegate {
    func didFinishLoading() {
        logger(message: "Finished loading posts.")
        logger(message: "Reddit posts available \(redditFeed.redditPosts.count)")
        self.collectionView.reloadData()
        if self.collectionView.refreshControl != nil {
            logger(message: "Will stop refreshing.")
            self.collectionView.refreshControl!.endRefreshing()
        }
    }
}
