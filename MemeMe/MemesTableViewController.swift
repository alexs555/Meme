//
//  MemesTableViewController.swift
//  MemeMe
//
//  Created by Алексей Шпирко on 11/07/15.
//  Copyright (c) 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

class MemesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sent memes"
        tableView.rowHeight = 120

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeStorage.sharedInstance.memesCount()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell", forIndexPath: indexPath) as! UITableViewCell
        
        if let meme = MemeStorage.sharedInstance.memeForIndexPath(indexPath) {
            
            cell.imageView?.image = meme.memedImage
            cell.textLabel?.text = meme.topText
        }

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showPreview") {
            
            if let indexPath = tableView?.indexPathForCell(sender as! UITableViewCell) {
                
                if let meme = MemeStorage.sharedInstance.memeForIndexPath(indexPath) {
                    
                    let previewVC = segue.destinationViewController as! MemePreview
                    previewVC.hidesBottomBarWhenPushed = true
                    previewVC.currentMeme = meme
                }
            }
        }
    }
    
}
