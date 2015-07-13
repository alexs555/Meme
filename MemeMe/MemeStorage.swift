//
//  MemeStorage.swift
//  MemeMe
//
//  Created by Алексей Шпирко on 11/07/15.
//  Copyright (c) 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation

class MemeStorage {
    
    static let sharedInstance = MemeStorage()
    
    private var memes:[Meme] = []
    
    func addMeme(meme:Meme) {
        
        self.memes.append(meme)
    }
    
    func memesCount() -> Int {
        
        return self.memes.count
    }
    
    func memeForIndexPath(indexPath:NSIndexPath) -> Meme? {
        
        return self.memes[indexPath.row]
    }
}
