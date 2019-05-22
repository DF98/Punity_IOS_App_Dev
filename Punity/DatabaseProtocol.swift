//
//  DatabaseProtocol.swift
//  Punity
//
//  Created by Damian Farinaccio on 20/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation

enum DatabaseChange {
    case add
    case remove
    case update
}
enum ListenerType {
    case podcasts
    case users
    case videos
    case all
}
protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onPodcastListChange(change: DatabaseChange, podcasts: [Podcast])
    func onUserListChange(change: DatabaseChange, users: [User])
    func onVideoListChange(change: DatabaseChange, videos: [Video])
    
    //func onTeamChange(change: DatabaseChange, teamHeroes: [SuperHero])
    //func onHeroListChange(change: DatabaseChange, heroes: [SuperHero])
}
protocol DatabaseProtocol: AnyObject {
    //var defaultTeam: Team {get}
    /*
    //--USERS--
    func addUser(id: Int, username:String, password:String, email:String, dob: Date, country: String) -> User
    func deleteUser(user: User)
     */
    
    //--PODCASTS--
    func addPodcast(name: String, videos: [Video])
    func deletePodcast(podcast: Podcast)
    //--VIDEO--
    func addVideo(title: String, description:String, publishdate: Date, comments: [Comment], likes :Int, dislikes: Int, link: String)
    func deleteVideo(video: Video)
    func getVideoIndexByID(reference: String) -> Int?
    func getVideoByID(reference: String) ->Video?
    
    //--REMOVE/ADD LISTENER FUNCTIONS
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
