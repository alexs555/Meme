//
//  Meme.swift
//  MemeMe
//
//  Created by Алексей Шпирко on 11/07/15.
//  Copyright (c) 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import UIKit

//Meme has to be class, not struc in order to simplify == method (Equatable support)
class Meme:Equatable {
    
    var topText: String
    var bottomText: String
    var image: UIImage?
    var memedImage: UIImage
    
    init (topText:String, bottomText:String, image:UIImage?, memedImage:UIImage) {
        
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
        
    }
    
}

func ==(lhs: Meme, rhs: Meme) -> Bool
{
    return lhs === rhs
}