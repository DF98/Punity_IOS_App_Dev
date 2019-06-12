//
//  ProfileViewController.swift
//  Punity
//
//  Created by Damian Farinaccio on 12/6/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, DatabaseListener {
    var listenerType = ListenerType.users
    
    var users: [User] = []
    
    func onPodcastVideosChange(change: DatabaseChange, podcastVideos: [Video]) {
        
    }
    
    func onUserListChange(change: DatabaseChange, users: [User]) {
        self.users = users
    }
    
    func onVideoListChange(change: DatabaseChange, videos: [Video]) {
        
    }
    
    func onPodcastListChange(change: DatabaseChange, podcasts: [Podcast]) {
        
    }
    
    weak var userDelegate: AddUserDelegate?
    weak var databaseController: DatabaseProtocol?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
         nameLabel.text = users[0].username
        passwordLabel.text = users[0].password
        emailLabel.text = users[0].email
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
