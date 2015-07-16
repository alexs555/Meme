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
        self.imageView.image = currentMeme?.memedImage
        self.navigationItem.title = "Preview"
        
    }
    
}

   