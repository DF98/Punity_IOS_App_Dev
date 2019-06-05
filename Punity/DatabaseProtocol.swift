//
//  DatabaseProtocol.swift
//  Punity
//
//  Created by Damian Farinaccio on 20/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation
import Firebase

enum DatabaseChange {
    case add
    case remove
    case update
}
enum ListenerType {
    case podcastVideos
    case podcasts
    case users
    case videos
    case all
}
protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onPodcastVideosChange(change: DatabaseChange, podcastVideos: [Video])
    func onUserListChange(change: DatabaseChange, users: [User])
    func onVideoListChange(change: DatabaseChange, videos: [Video])
    func onPodcastListChange(change: DatabaseChange, podcasts: [Podcast])
    
    //func onTeamChange(change: DatabaseChange, teamHeroes: [SuperHero])
    //func onHeroListChange(change: DatabaseChange, heroes: [SuperHero])
}
protocol DatabaseProtocol: AnyObject {
    var defaultPodcast: Podcast {get}
    /*
    //--USERS--
    func addUser(id: Int, username:String, password:String, email:String, dob: Date, country: String) -> User
    func deleteUser(user: User)
     */
    
    //--PODCASTS--
    func addPodcast(name: String, videos: [Video]) -> Podcast
    func deletePodcast(podcast: Podcast)
    //func onPodcastListChange(change: DatabaseChange, podcasts: [Podcast])
    //--VIDEO--
    func addVideo(title: String, description:String, publishdate: Timestamp, comments: [Comment], likes :Int, dislikes: Int, link: String) ->Video
    func deleteVideo(video: Video)
    func getVideoIndexByID(reference: String) -> Int?
    func getVideoByID(reference: String) ->Video?
    
    //-- VIDEO/PODCAST --
    func addVideoToPodcast(video: Video, podcast: Podcast) -> Bool
    func removeVideoFromPodcast(video: Video, podcast: Podcast)
    
    //--REMOVE/ADD LISTENER FUNCTIONS
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
