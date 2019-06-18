//
//  AddUserDelegate.swift
//  Punity
//
//  Created by Damian Farinaccio on 12/6/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation

protocol AddUserDelegate: AnyObject {
    func addUser(newUser: User) -> Bool
}
