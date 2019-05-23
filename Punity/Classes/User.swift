//
//  User.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation

class User: NSObject
{
    var userID: Int
    var username: String
    var password: String
    var email: String
    var dob: Date
    var country: String
    
    
    override init()
    {
        self.userID = 0
        self.username = ""
        self.password = ""
        self.email = ""
        self.dob = Date()
        self.country = ""
    }
 
    
    init(id: Int, username:String, password:String, email:String, dob: Date, country: String)
    {
        self.userID = id
        self.username = username
        self.password = password
        self.email = email
        self.dob = dob
        self.country = country
    }
}
