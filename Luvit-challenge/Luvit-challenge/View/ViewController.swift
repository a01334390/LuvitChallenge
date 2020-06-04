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
    
    // MARK: - Other views
    let deleteButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let image = UIImage(systemName: "minus.circle.fill", withConfiguration: largeConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .red
        button.layer.zPosition = 2
        return button
    }()
    var deleteButtonWasAdded : Bool = false
    

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
        collectionView.layer.zPosition = 1
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
    
    private func addDeleteButton() {
        guard !deleteButtonWasAdded else { return }
        deleteButtonWasAdded = true
        
        let rootVC = UIApplication.shared.windows.first?.rootViewController
        let deleteButtonSize: CGFloat = 100
        deleteButton.frame = CGRect(x: UIScreen.main.bounds.width - deleteButtonSize - 5,
                                    y: UIScreen.main.bounds.height - deleteButtonSize - 5,
                                    width: deleteButtonSize,
                                    height: deleteButtonSize)
        deleteButton.addTarget(self, action: #selector(deleteAll), for: .touchUpInside)
        rootVC?.view.addSubview(deleteButton)
        rootVC?.view.bringSubviewToFront(deleteButton)
    }
    
    @objc func deleteAll() {
        self.logger(message: "will delete all items.")
        self.redditFeed.redditPosts.removeAll()
        self.collectionView.reloadData()
    }
    
    @objc func refresh() {
        self.redditFeed.restore()
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: "VRedditCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VRedditCollectionViewCell")
        self.logger(message: "Cells successfully registered")
    }
    
    // MARK: - Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (redditFeed.redditPosts.count - 10) < indexPath.row {
            self.logger(message: "Will load more posts...")
            self.redditFeed.loadMorePosts()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let thumbnail = redditFeed.redditPosts[indexPath.row].data?.thumbnail {
            NetworkController.shared().downloadImage(from: thumbnail) { thumbnail in
                self.save(image: thumbnail)
            }
        } else {
            self.save(image: UIImage(named: "robot")!)
        }
    }
}


// MARK: - Collection View Datasource Methods

extension ViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if redditFeed.redditPosts.count == 0 {
            self.collectionView.setLoading()
        } else {
            self.collectionView.restore()
        }
        
        return redditFeed.redditPosts.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VRedditCollectionViewCell", for: indexPath) as! VRedditCollectionViewCell
        if redditFeed.redditPosts.indices.contains(indexPath.row) {
            cell.configure(with: redditFeed.redditPosts[indexPath.row])
        }
        return cell
    }
}

// MARK: - Collection View Flow Layout Methods

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 20, height: 120)
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
        self.addDeleteButton()
        if self.collectionView.refreshControl != nil {
            logger(message: "Will stop refreshing.")
            self.collectionView.refreshControl!.endRefreshing()
        }
    }
}


extension ViewController {
    //MARK: - Save image

    func save(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    //MARK: - Save Image callback

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.logger(message: "An error occured: \(error.localizedDescription )")
        } else {
            self.logger(message: "Image was saved successfully.")
        }
    }
}
