//
//  MemePreview.swift
//  MemeMe
//
//  Created by Алексей Шпирко on 15/07/15.
//  Copyright (c) 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import UIKit


class MemePreview: UIViewController {
    
    var currentMeme:Meme?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //meme is injected from lists
        imageView.image = currentMeme?.memedImage
        navigationItem.title = "Preview"
        
        customizeNavigationBar()
        
    }
    
    private func customizeNavigationBar() {
        
        var editItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editMeme")
         var deleteItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "removeMeme")
        navigationItem.rightBarButtonItems = [editItem,deleteItem]
    }
    
    func editMeme() {
        
        
    }
    
    func removeMeme() {
        
        MemeStorage.sharedInstance.removeMeme(currentMeme!)
        navigationController?.popViewControllerAnimated(true)
    }
}

   