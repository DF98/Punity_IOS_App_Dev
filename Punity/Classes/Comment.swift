//
//  Comment.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation
class Comment
{
    //--VARIABLES--
    var comment_content: String
    var comment_date_published: Date
    var comment_likes: Int
    var comment_dislikes: Int
    
    //--CONSTRUCTOR--
    init(content: String, datePublished: Date, likes: Int, dislikes: Int)
    {
        self.comment_content = content
        self.comment_date_published = datePublished
        self.comment_dislikes = dislikes
        self.comment_likes = likes
    }
}
