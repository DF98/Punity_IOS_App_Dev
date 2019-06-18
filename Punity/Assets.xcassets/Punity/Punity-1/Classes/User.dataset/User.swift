//
//  User.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation
import Firebase

class User: NSObject
{
    var userID: String
    var username: String
    var password: String
    var email: String
    var dob: Timestamp
    var podcasts: [Podcast]
    
    
    override init()
    {
        self.userID = ""
        self.username = ""
        self.password = ""
        self.email = ""
        self.dob = Timestamp()
        self.podcasts = []
        
    }
 
    
    init(id: String, username:String, password:String, email:String, dob: Timestamp, podcasts: [Podcast])
    {
        self.userID = id
        self.username = username
        self.password = password
        self.email = email
        self.dob = dob
        self.podcasts = podcasts
        
    }
}
