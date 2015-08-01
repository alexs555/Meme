//
//  MemePreview.swift
//  MemeMe
//
//  Created by Алексей Шпирко on 15/07/15.
//  Copyright (c) 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import UIKit
import Swift


class MemePreview: UIViewController {
    
    var currentMeme:Meme?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Preview"
        
        customizeNavigationBar()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        imageView.image = currentMeme?.memedImage
    }
    
    private func customizeNavigationBar() {
        
        var editItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editMeme")
         var deleteItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "removeMeme")
        navigationItem.rightBarButtonItems = [editItem,deleteItem]
    }
    
    func editMeme() {
        
        self.performSegueWithIdentifier("edit", sender: self)
    }
    
    func removeMeme() {
        
        MemeStorage.sharedInstance.removeMeme(currentMeme!)
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "edit") {
            
            let editorVC = segue.destinationViewController as! MemeEditor
            editorVC.editingMeme = currentMeme
        }
    }
}

   