//
//  Meme.swift
//  MemeMe
//
//  Created by Алексей Шпирко on 11/07/15.
//  Copyright (c) 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var text: String
    var image: UIImage?
    var memedImage: UIImage
    
    init (text:String, image:UIImage?, memedImage:UIImage) {
        
        self.text = text
        self.image = image
        self.memedImage = memedImage
        
    }
    
}