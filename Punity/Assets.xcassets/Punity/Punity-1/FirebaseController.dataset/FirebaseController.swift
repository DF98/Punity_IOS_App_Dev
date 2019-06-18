

//
//  FirebaseController.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//



import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore



class FirebaseController: NSObject, DatabaseProtocol {
  

    let DEFAULT_PODCAST_NAME = "Cool Podcast"
    var listeners = MulticastDelegate<DatabaseListener>()
    var authController: Auth
    var database: Firestore
    
    //******** REFERENCES  ***********
    var usersRef: CollectionReference?
    var podcastsRef: CollectionReference?
    var videosRef: CollectionReference?
    var commentsRef: CollectionReference?
    
    //******** LISTS  ***********
    var userList: [User]
    var podcastList: [Podcast]
    var videoList: [Video]
    var commentList: [Comment]
    
    var defaultPodcast: Podcast
    //var defaultTeam: Team
    
    override init() {
        // To use Firebase in our application we first must run the FirebaseApp configure method
        FirebaseApp.configure()
        // We call auth and firestore to get access to these frameworks
        authController = Auth.auth()
        database = Firestore.firestore()
        userList = [User]()
        podcastList = [Podcast]()
        videoList = [Video]()
        commentList = [Comment]()
        defaultPodcast = Podcast()
        
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
    
    func setUpListeners()
    {
        
        videosRef = database.collection("videos")
        videosRef?.addSnapshotListener { querySnapshot, error in
            guard (querySnapshot?.documents) != nil else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.parseVideosSnapshot(snapshot: querySnapshot!)
        }
        
        podcastsRef = database.collection("podcasts")
        podcastsRef?.addSnapshotListener { querySnapshot, error in
            guard (querySnapshot?.documents) != nil else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.parsePodcastSnapshot(snapshot: querySnapshot!)
        }
        /*
        podcastsRef?.whereField("pod_name", isEqualTo: DEFAULT_PODCAST_NAME).addSnapshotListener { querySnapshot,
            error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching teams: \(error!)")
                return
            }
            self.parsePodcastSnapshot(snapshot: documents.first!)
 */
        
        
        
        
        //SETTING UP THE USERS LISTENER
        usersRef = database.collection("users")
        usersRef?.addSnapshotListener { querySnapshot, error in
            guard (querySnapshot?.documents) != nil else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.parseUsersSnapshot(snapshot: querySnapshot!)
        }
        /*
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
 */
    }
    

    func parseUsersSnapshot (snapshot: QuerySnapshot)
    {
        snapshot.documentChanges.forEach { change in
            let documentRef = change.document.documentID
            let user_name = change.document.data()["username"] as! String
            let password = change.document.data()["password"] as! String
            let email = change.document.data()["email"] as! String
            let dob = change.document.data()["dob"] as! Timestamp
            

            if change.type == .added
            {
                print("New User: \(change.document.data())")
                
                let newUser = User()
                
                newUser.username = user_name
                newUser.email = email
                newUser.password = password
                newUser.dob = dob
                
                
                
                self.userList.append(newUser)
            }
            
            if change.type == .modified
            {
                print("Updated User: \(change.document.data())")
                let index = getUserIndexByID(reference: documentRef)!
                
                userList[index].userID = documentRef
                userList[index].email = email
                userList[index].dob = dob
                userList[index].password = password
                userList[index].username = user_name
            }
            
            if change.type == .removed
            {
                
                print("Removed Video: \(change.document.data())")
                if let index = getUserIndexByID(reference: documentRef) {
                    userList.remove(at: index)
                }
                
            }
            
            listeners.invoke { (listener) in
                if listener.listenerType == ListenerType.users || listener.listenerType == ListenerType.all {
                    listener.onUserListChange(change: .update, users: userList)
                }
            }
            
        }
        
    }
    
    func getUserIndexByID(reference: String) -> Int?
    {
        for user in userList
        {
            if(user.userID == reference)
            {
                //this line throws an error
                return userList.index(of: user)
            }
        }
        
        return nil
    }
    
    func getUserByID(reference: String) ->User?
    {
        for user in userList
        {
            if(user.userID == reference)
            {
                return user
            }
        }
        return nil
    }
    
    func addUser(username: String, password: String, dob: Timestamp, email: String) -> User
    {
        let user = User()
        
        let id = usersRef?.addDocument(data: ["dob": dob, "email": email,"password": password ,"username": username])
        
        user.password = password
        user.username = username
        user.dob = dob
        user.email = email
        
        return user
    }

    func deleteUser(user: User)
    {
        usersRef?.document(user.userID).delete()
    }
    
//***********************************  VIDEO  *********************************************
    func parseVideosSnapshot(snapshot: QuerySnapshot)
    {
        snapshot.documentChanges.forEach { change in
            let documentRef = change.document.documentID
            let title = change.document.data()["video_title"] as! String
            let pub_date = change.document.data()["video_pubdate"] as! Timestamp
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
                
               
                /*
                videoList.append(newVideo)
                 */
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
                //return videoList.index(of: video)
            }
        }
        
        return nil
    }
    
    func getVideoByID(reference: String) ->Video?
    {
        for video in videoList
        {
            if(video.video_id == reference)
            {
                return video
            }
        }
        return nil
    }
    
    func addVideo(title: String, description: String, publishdate: Timestamp, comments: [Comment], likes: Int, dislikes: Int, link: String) -> Video
    {
        let video = Video()
        let id = videosRef?.addDocument(data: ["video_title": title, "video_desc": description,"video_pubdate": publishdate ,"video_comments": comments, "video_likes": likes,"video_dislikes": dislikes, "video_link": link ])
       
        video.video_title = title
        video.video_desc = description
        video.video_pubdate = publishdate as Timestamp
        video.video_comments = comments
        video.video_likes = likes
        video.video_dislikes = dislikes
        video.video_link = link
        video.video_id = id!.documentID
        
        return video
    }
    
    func deleteVideo(video: Video) {
        videosRef?.document(video.video_id).delete()
    }
   
//*****************************************************************************************
    

    //***********************************  PODCAST  *********************************************
    
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
    
    
    func parsePodcastSnapshot(snapshot: QuerySnapshot)
    {
       
    
            
        snapshot.documentChanges.forEach { change in
            let documentRef = change.document.documentID
            let name = change.document.data()["pod_name"] as! String
            let rssLink = change.document.data()["rss_link"] as! String
            
            
            
            podcastsRef?.whereField("pod_name", isEqualTo: name).addSnapshotListener { querySnapshot,
                error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching podcast: \(error!)")
                    return
                }
                let documentSnaphot = documents.first!
                //self.parsePodcastSnapshot(snapshot: documents.first!)
                
                
                if let videoReferences = documentSnaphot.data()["pod_videos"] as? [DocumentReference] {
                    // If the document has a "heroes" field, add heroes.
                    for reference in videoReferences {
                        let video = self.getVideoByID(reference: reference.documentID)
                        guard video != nil else {
                            continue
                        }
                        //podcastVideos.append(video!)
                    }
                }
            }
            
            
            
                    print(documentRef)
            
            
                    
                    if change.type == .added {
                        print("New Podcast: \(change.document.data())")
                        let newPodcast = Podcast()
                        newPodcast.pod_id = documentRef
                        newPodcast.rss_link = rssLink
                        newPodcast.pod_name = name
                        //newPodcast.pod_videos = podcastVideos
                        
                        //get all of the videos in the podcast
                        
                        
                        
                        self.podcastList.append(newPodcast)
                    }
                    if change.type == .modified {
                        print("Updated Podcast: \(change.document.data())")
                        
                        let index = getPodcastIndexByID(reference: documentRef)!
                        podcastList[index].rss_link = rssLink
                        podcastList[index].pod_name = name
                        
                        podcastList[index].pod_id = documentRef
                        
                    }
                    if change.type == .removed {
                        print("Removed Podcast: \(change.document.data())")
                        if let index = getVideoIndexByID(reference: documentRef) {
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
            
            /*
             func parsePodcastSnapshot(snapshot: QueryDocumentSnapshot) {
             
             defaultPodcast = Podcast()
             print(snapshot)
             defaultPodcast.pod_name = (snapshot.data()["pod_name"] as! String)
             defaultPodcast.pod_id = snapshot.documentID
             
             if let videoReferences = snapshot.data()["pod_videos"] as? [DocumentReference] {
             // If the document has a "heroes" field, add heroes.
             for reference in videoReferences {
             let video = getVideoByID(reference: reference.documentID)
             guard video != nil else {
             continue
             }
             defaultPodcast.pod_videos.append(video!)
             
             }
             }
             
             listeners.invoke { (listener) in
             if listener.listenerType == ListenerType.podcasts || listener.listenerType == ListenerType.all {
             listener.onPodcastVideosChange(change: .update, podcastVideos: defaultPodcast.pod_videos)
             listener.onPodcastListChange(change: .update, podcasts: podcastList)
             }
             }
             
             }
             */
            /*
             func onPodcastListChange(change: DatabaseChange, podcasts: [Podcast]) {
             
             }
             */
            
            
            
            /*
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
             */
    
    func getPodcastByID(reference: String) -> Podcast? {
        for podcast in podcastList {
            if(podcast.pod_id == reference) {
                return podcast
            }
        }
        
        return nil
    }
          
            
            func addPodcast(name: String, videos: [Video]) -> Podcast
            {
                let podcast = Podcast()
                let id = podcastsRef?.addDocument(data: ["pod_name": name, "pod_videos": videos])
                
                podcast.pod_name = name
                //podcast.pod_videos = videos
                podcast.pod_id = id!.documentID
                
                return podcast
            }
            
            func deletePodcast(podcast: Podcast) {
                podcastsRef?.document(podcast.pod_id).delete()
            }
            
            func addVideoToPodcast(video: Video, podcast: Podcast) ->Bool
            {
                guard let video = getVideoByID(reference: video.video_id), podcast.pod_videos.count < 6 else
                {
                    return false
                }
                podcast.pod_videos.append(video)
                
                let newVideoRef = videosRef!.document(video.video_id)
                podcastsRef?.document(podcast.pod_id).updateData(["pod_videos" : FieldValue.arrayUnion([newVideoRef])])
                return true
            }
            
            func removeVideoFromPodcast(video: Video, podcast: Podcast)
            {
                let index = podcast.pod_videos.index(of: video)
                let removedVideo = podcast.pod_videos.remove(at: index!)
                let removedRef = podcastsRef?.document(removedVideo.video_id)
                
                podcastsRef?.document(podcast.pod_id).updateData(["pod_videos": FieldValue.arrayRemove([removedRef!])])
            }
            
//*****************************************************************************************
    

    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == ListenerType.podcastVideos || listener.listenerType == ListenerType.all {
            listener.onPodcastVideosChange(change: .update, podcastVideos: defaultPodcast.pod_videos)
        }
        
        if listener.listenerType == ListenerType.users || listener.listenerType == ListenerType.all {
            listener.onUserListChange(change: .update, users: userList)
        }
        
        if listener.listenerType == ListenerType.videos || listener.listenerType == ListenerType.all {
            listener.onVideoListChange(change: .update, videos: videoList)
        }
        if listener.listenerType == ListenerType.podcasts || listener.listenerType == ListenerType.all {
            listener.onPodcastListChange(change: .update, podcasts: podcastList)
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    

    
 
    
}




