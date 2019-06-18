//
//  AddPodcastDelegate.swift
//  Punity
//
//  Created by Damian Farinaccio on 23/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation
protocol AddPodcastDelegate: AnyObject {
    func addPodcast(newPodcast: Podcast) -> Bool
}
