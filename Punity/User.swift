//
//  User.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation

class User
{
    var username: String
    var password: String
    var email: String
    var dob: Date
    var country: String
    
    init(username:String, password:String, email:String, dob: Date, country: String)
    {
        self.username = username
        self.password = password
        self.email = email
        self.dob = dob
        self.country = country
    }
}
