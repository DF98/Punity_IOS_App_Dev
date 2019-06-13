//
//  LoginViewController.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/6/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class LoginViewController: ViewController, DatabaseListener {
    func onPodcastVideosChange(change: DatabaseChange, podcastVideos: [Video]) {
        
    }
    
    func onUserListChange(change: DatabaseChange, users: [User]) {
        userList = users
    }
    
    func onVideoListChange(change: DatabaseChange, videos: [Video]) {
        
    }
    
    func onPodcastListChange(change: DatabaseChange, podcasts: [Podcast]) {
        
    }
    
    
    var listenerType = ListenerType.users
    
    var userList: [User] = []
    var wantedUser = User()
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var enteredUsername: String = ""
    var enteredPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if (usernameField.text != "" || passwordField.text != "")
        {
            enteredUsername = usernameField.text!
            enteredPassword = passwordField.text!
        }
        else
        {
            print("password and username field are empty")
        }
        
        for user in userList
        {
            if(user.username == enteredUsername && user.password == enteredPassword)
            {
                wantedUser.username = user.username
                wantedUser.password = user.password
                wantedUser.email = user.email
                wantedUser.dob = user.dob
                wantedUser.userID = user.userID
                
                //performSegue(withIdentifier: "login_main_segue", sender: self)
            }
            else
            {
                //performSegue(withIdentifier: "", sender: nil)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
         let desiredScreen = segue.destination as! MainViewController
        // Pass the selected object to the new view controller.
        desiredScreen.user = wantedUser
    }
    

}
