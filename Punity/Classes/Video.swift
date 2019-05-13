//
//  Video.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation
class Video
{
    //--VARIABLES--
    var video_title: String
    var video_desc: String
    var video_pubdate: Date
    var video_comments:[Comment]
    var video_likes: Int
    var video_dislikes: Int

    //--CONSTRUCTOR--
    init(title: String, description:String, publishdate: Date, comments: [Comment], likes :Int, dislikes: Int)
    {
        
    }
    
}
