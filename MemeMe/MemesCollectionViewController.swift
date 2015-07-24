//
//  MemesCollectionViewController.swift
//  MemeMe
//
//  Created by Алексей Шпирко on 11/07/15.
//  Copyright (c) 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class MemesCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sent memes"
        
        configureCollectionView()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
    }


    func configureCollectionView() {
        
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(collectionView!.frame.size.width/3-10, collectionView!.frame.size.width/3-10)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        collectionView?.collectionViewLayout = flowLayout
        

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeStorage.sharedInstance.memesCount()
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! MemeCell
        
        if let meme = MemeStorage.sharedInstance.memeForIndexPath(indexPath) {
            
            cell.imageView?.image = meme.memedImage
        }
    
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showPreview") {
            
            if let indexPath = collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
                
                if let meme = MemeStorage.sharedInstance.memeForIndexPath(indexPath) {
                    
                    let previewVC = segue.destinationViewController as! MemePreview
                    previewVC.currentMeme = meme
                }
            }
        }
    }
}
