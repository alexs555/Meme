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
        
        self.navigationItem.title = "Sent memes"
        self.tableView.rowHeight = 120

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeStorage.sharedInstance.memesCount()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell", forIndexPath: indexPath) as! UITableViewCell
        
        if let meme = MemeStorage.sharedInstance.memeForIndexPath(indexPath) {
            
            cell.imageView?.image = meme.memedImage
            cell.textLabel?.text = meme.text
        }

        return cell
    }
    
     override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    
        if let meme = MemeStorage.sharedInstance.memeForIndexPath(indexPath) {
         
            
            
        }
    
    }
    
}
