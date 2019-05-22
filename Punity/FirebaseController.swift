//
//  FirebaseController.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore



class FirebaseController: NSObject, DatabaseProtocol {
    func addUser(id: Int, username: String, password: String, email: String, dob: Date, country: String) -> User {
        <#code#>
    }
    
    func deleteUser(user: User) {
        <#code#>
    }
    
    func addPodcast(name: String, videos: [Video]) {
        <#code#>
    }
    
    func deletePodcast(podcast: Podcast) {
        <#code#>
    }
    
    func addVideo(title: String, description: String, publishdate: Date, comments: [Comment], likes: Int, dislikes: Int) {
        <#code#>
    }
    
    func deletVideo(video: Video) {
        <#code#>
    }
    
    

    let DEFAULT_TEAM_NAME = "Default Team"
    var listeners = MulticastDelegate<DatabaseListener>()
    var authController: Auth
    var database: Firestore
    var usersRef: CollectionReference?
    var podcastsRef: CollectionReference?
    var videosRef: CollectionReference?
    var commentsRef: CollectionReference?
    
    
    var userList: [User]
    var podcastList: [Podcast]
    var videoList: [Video]
    var commentList: [Comment]
    //var defaultTeam: Team
    
    override init() {
        // To use Firebase in our application we first must run the FirebaseApp configure method
        FirebaseApp.configure()
        // We call auth and firestore to get access to these frameworks
        authController = Auth.auth()
        database = Firestore.firestore()
        userList = [User]()
        //defaultTeam = Team()
        
        super.init()
        
        // This will START THE PROCESS of signing in with an anonymous account
        // The closure will not execute until its recieved a message back which can be any time later
        authController.signInAnonymously() { (authResult, error) in
            guard authResult != nil else {
                fatalError("Firebase authentication failed")
            }
            // Once we have authenticated we can attach our listeners to the firebase firestore
            self.setUpListeners()
            
        }
    }
    
    func setUpListeners() {
        
        //SETTING UP THE USERS LISTENER
        usersRef = database.collection("users")
        usersRef?.addSnapshotListener { querySnapshot, error in
            guard (querySnapshot?.documents) != nil else {
                print("Error fetching documents: \(error!)")
                return
            }
            //self.parseUsersSnapshot(snapshot: querySnapshot!)
        }
        
        //SETTING UP THE PODCASTS LISTENER
        podcastsRef = database.collection("podcasts")
        podcastsRef?.addSnapshotListener { querySnapshot,
            error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching teams: \(error!)")
                return
            }
            //self.parsePodcastsSnapshot(snapshot: querySnapshot!)
        }
        
        
        //SETTING UP THE VIDEOS LISTENER
        videosRef = database.collection("videos")
        videosRef?.addSnapshotListener { querySnapshot,
            error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching teams: \(error!)")
                return
            }
            //self.parseVideosSnapshot(snapshot: querySnapshot!)
        }
        
        //SETTING UP THE COMMENTS LISTENER
        commentsRef = database.collection("comments")
        commentsRef?.addSnapshotListener { querySnapshot,
            error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching teams: \(error!)")
                return
            }
            //self.parseCommentsSnapshot(snapshot: querySnapshot!)
        }
    }
    
//***********************************  PODCAST  *********************************************
    func parsePodcastsSnapshot(snapshot: QuerySnapshot)
    {
        snapshot.documentChanges.forEach { change in
            let documentRef = change.document.documentID
            let pod_name = change.document.data()["pod_name"] as! String
            let videos = change.document.data()["videos"] as! [Video]
            print(documentRef)
            
            if change.type == .added {
                print("New Podcast: \(change.document.data())")
                let newPodcast = Podcast()
                newPodcast.pod_name = pod_name
                newPodcast.pod_videos = videos
                newPodcast.pod_id = documentRef
                
                podcastList.append(newPodcast)
            }
            if change.type == .modified {
                print("Updated Podcast: \(change.document.data())")
                
                let index = getPodcastIndexByID(reference: documentRef)!
                podcastList[index].pod_name = pod_name
                podcastList[index].pod_videos = videos
                podcastList[index].pod_id = documentRef
            }
            if change.type == .removed {
                print("Removed Podcast: \(change.document.data())")
                if let index = getPodcastIndexByID(reference: documentRef) {
                    podcastList.remove(at: index)
                }
            }
        }
        
        listeners.invoke { (listener) in
            if listener.listenerType == ListenerType.podcasts || listener.listenerType == ListenerType.all {
                listener.onPodcastListChange(change: .update, podcasts: podcastList)
            }
        }
    }
    
    func getPodcastIndexByID(reference: String) -> Int?
    {
        for podcast in podcastList
        {
            if(podcast.pod_id == reference)
            {
                //this line throws an error
                //return podcastList.firstIndex(of: podcast)
            }
        }
        
        return nil
    }
    
//*****************************************************************************************
    

    
//***********************************  VIDEO  *********************************************
    func parseVideosSnapshot(snapshot: QuerySnapshot)
    {
        snapshot.documentChanges.forEach { change in
            let documentRef = change.document.documentID
            let title = change.document.data()["video_title"] as! String
            let pub_date = change.document.data()["video_pubdate"] as! Date
            let description = change.document.data()["video_desc"] as! String
            let comments = change.document.data()["video_comments"] as!  [Comment]
            let dislikes = change.document.data()["video_dislikes"] as! Int
            let likes = change.document.data()["video_likes"] as! Int
            let link = change.document.data()["video_link"] as! String
            print(documentRef)
            
            if change.type == .added {
                print("New Video: \(change.document.data())")
                let newVideo = Video()
                newVideo.video_title = title
                newVideo.video_pubdate = pub_date
                newVideo.video_comments = comments
                newVideo.video_desc = description
                newVideo.video_dislikes = dislikes
                newVideo.video_likes = likes
                newVideo.video_link = link
                newVideo.video_id = documentRef
                
                videoList.append(newVideo)
            }
            if change.type == .modified {
                print("Updated Video: \(change.document.data())")
                
                let index = getVideoIndexByID(reference: documentRef)!
                videoList[index].video_title = title
                videoList[index].video_pubdate = pub_date
                videoList[index].video_desc = description
                videoList[index].video_comments = comments
                videoList[index].video_dislikes = dislikes
                videoList[index].video_likes = likes
                videoList[index].video_link = link
                videoList[index].video_id = documentRef
            }
            if change.type == .removed {
                print("Removed Video: \(change.document.data())")
                if let index = getVideoIndexByID(reference: documentRef) {
                    videoList.remove(at: index)
                }
            }
        }
        
        listeners.invoke { (listener) in
            if listener.listenerType == ListenerType.videos || listener.listenerType == ListenerType.all {
                listener.onVideoListChange(change: .update, videos: videoList)
            }
        }
    }
    
    func getVideoIndexByID(reference: String) -> Int?
    {
        for video in videoList
        {
            if(video.video_id == reference)
            {
                //this line throws an error
                //return videoList.first(of: video)
            }
        }
        
        return nil
    }
   
//*****************************************************************************************
    
    
    
   /*
    func parseUsersSnapshot(snapshot: QuerySnapshot) {
        snapshot.documentChanges.forEach { change in
            
            //----setting up variables for each field in 'users'
            let documentRef = change.document.documentID
            let username = change.document.data()["username"] as! String
            let password = change.document.data()["password"] as! String
            let email = change.document.data()["email"] as! String
            let dob = change.document.data()["dob"] as! Date
            let country = change.document.data()["country"] as! String
            
            print(documentRef)
            
            if change.type == .added {
                print("New Hero: \(change.document.data())")
                let newUser = User()
                newUser.username = username
                newUser.password = password
                newUser.email = email
                newUser.dob = dob
                newUser.country = country
                newUser.id = documentRef
                userList.append(newUser)
            }
            if change.type == .modified {
                print("Updated Hero: \(change.document.data())")
                let index = getUserIndexByID(reference: documentRef)!
                userList[index].username = username
                userList[index].password = password
                userList[index].id = documentRef
            }
            if change.type == .removed {
                print("Removed Hero: \(change.document.data())")
                if let index = getUserIndexByID(reference: documentRef) {
                    userList.remove(at: index)
                }
            }
        }
        
        listeners.invoke { (listener) in
            if listener.listenerType == ListenerType.users || listener.listenerType == ListenerType.all {
                listener.onHeroListChange(change: .update, users: userList)
            }
        }
    }
 */
    
/*
    func parseTeamSnapshot(snapshot: QueryDocumentSnapshot) {
        defaultTeam = Team()
        defaultTeam.name = (snapshot.data()["name"] as! String)
        defaultTeam.id = snapshot.documentID
        if let heroReferences = snapshot.data()["heroes"] as? [DocumentReference] {
            // If the document has a "heroes" field, add heroes.
            for reference in heroReferences {
                let hero = getHeroByID(reference: reference.documentID)
                guard hero != nil else {
                    continue
                }
                defaultTeam.heroes.append(hero!)
            }
        }
        
        listeners.invoke { (listener) in
            if listener.listenerType == ListenerType.team || listener.listenerType == ListenerType.all {
                listener.onTeamChange(change: .update, teamHeroes: defaultTeam.heroes)
            }
        }
        
    }
    
    func getUserIndexByID(reference: String) -> Int? {
        for user in userList {
            if(hero.id == reference) {
                return heroList.firstIndex(of: hero)
            }
        }
        
        return nil
    }
    
    func getHeroByID(reference: String) -> SuperHero? {
        for hero in heroList {
            if(hero.id == reference) {
                return hero
            }
        }
        
        return nil
    }
    
    func addSuperHero(name: String, abilities: String) -> SuperHero {
        let hero = SuperHero()
        let id = heroesRef?.addDocument(data: ["name" : name, "abilities" : abilities])
        hero.name = name
        hero.abilities = abilities
        hero.id = id!.documentID
        
        return hero
    }
    
    func addTeam(teamName: String) -> Team {
        let team = Team()
        let id = teamsRef?.addDocument(data: ["name" : teamName, "heroes": []])
        team.id = id!.documentID
        team.name = teamName
        
        return team
    }
    
    func addHeroToTeam(hero: SuperHero, team: Team) -> Bool {
        guard let hero = getHeroByID(reference: hero.id), team.heroes.count < 6 else {
            return false
        }
        
        team.heroes.append(hero)
        
        let newHeroRef = heroesRef!.document(hero.id)
        teamsRef?.document(team.id).updateData(["heroes" : FieldValue.arrayUnion([newHeroRef])])
        return true
    }
    
    func deleteSuperHero(hero: SuperHero) {
        heroesRef?.document(hero.id).delete()
    }
    
    func deleteTeam(team: Team) {
        teamsRef?.document(team.id).delete()
    }
    
    func removeHeroFromTeam(hero: SuperHero, team: Team) {
        let index = team.heroes.index(of: hero)
        let removedHero = team.heroes.remove(at: index!)
        let removedRef = heroesRef?.document(removedHero.id)
        
        teamsRef?.document(team.id).updateData(["heroes": FieldValue.arrayRemove([removedRef!])])
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == ListenerType.team || listener.listenerType == ListenerType.all {
            listener.onTeamChange(change: .update, teamHeroes: defaultTeam.heroes)
        }
        
        if listener.listenerType == ListenerType.heroes || listener.listenerType == ListenerType.all {
            listener.onHeroListChange(change: .update, heroes: heroList)
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
 */
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == ListenerType.podcasts || listener.listenerType == ListenerType.all {
            listener.onPodcastListChange(change: .update, podcasts: podcastList)
        }
        
        if listener.listenerType == ListenerType.users || listener.listenerType == ListenerType.all {
            listener.onUserListChange(change: .update, users: userList)
        }
        
        if listener.listenerType == ListenerType.videos || listener.listenerType == ListenerType.all {
            listener.onVideoListChange(change: .update, videos: videoList)
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
}

