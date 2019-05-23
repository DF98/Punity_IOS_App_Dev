//
//  Podcast.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation

class Podcast: NSObject
{
    //---VARIABLES--
    var pod_id: String
    var pod_name:String
    var pod_videos:[Video]
    
    
    override init()
    {
        self.pod_id = ""
        self.pod_name = ""
        self.pod_videos = []
    }
 
    

    init(id: String ,name: String, videos: [Video])
    {
        self.pod_id = id
        self.pod_name = name
        self.pod_videos = videos
    }
}
