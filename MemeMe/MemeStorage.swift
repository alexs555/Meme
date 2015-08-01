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
        
        memes.append(meme)
    }
    
    func memesCount() -> Int {
        
        return memes.count
    }
    
    func memeForIndexPath(indexPath:NSIndexPath) -> Meme? {
        
        return memes[indexPath.row]
    }
    
    func removeMeme(meme:Meme) {
       
        var index = find(memes,meme)
        memes.removeAtIndex(index!)
    }
}


