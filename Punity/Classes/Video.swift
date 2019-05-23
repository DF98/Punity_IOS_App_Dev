//
//  Video.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation

class Video: NSObject
{
    //--VARIABLES--
    
    var video_id: String
    var video_title: String
    var video_desc: String
    var video_pubdate: Date
    var video_comments:[Comment]
    var video_likes: Int
    var video_dislikes: Int
    var video_link: String
    

    //--CONSTRUCTORS--
    
    
    override init()
    {
        self.video_id = ""
        self.video_title = ""
        self.video_desc = ""
        self.video_pubdate = Date()
        self.video_comments = []
        self.video_likes = 0
        self.video_dislikes = 0
        self.video_link = ""
    }
 
     
    
    
    init(id: String, title: String, description:String, publishdate: Date, comments: [Comment], likes :Int, dislikes: Int, link: String)
    {
        self.video_id = id
        self.video_title = title
        self.video_desc = description
        self.video_pubdate = publishdate
        self.video_comments = comments
        self.video_likes = likes
        self.video_dislikes = dislikes
        self.video_link = link
    }
    
}
