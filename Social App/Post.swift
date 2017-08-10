//
//  Post.swift
//  Social App
//
//  Created by Мулярчук Константин on 10.08.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import Foundation

class Post {
    
    private var _caption : String!
    private var _postUrl: String!
    private var _likes : Int!
    private var _postId: String!
    
    var caption: String {
        return _caption
    }
    
    var postUrl: String {
        return _postUrl
    }
    var likes: Int {
        return _likes
    }
    var postId: String {
        return _postId
    }
    init(caption: String, postUrl: String, likes: Int) {
        self._caption = caption
        self._postUrl = postUrl
        self._likes = likes
    }
    init(postId: String, postData: Dictionary<String, Any>) {
        if let caption = postData["caption"] as? String {
             self._caption = caption
        }
        
        if let postUrl = postData["imageUrl"] as? String {
            self._postUrl = postUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }    
    }
}
