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
        //assing the list of users in this view controller to the users listed in firebase.
        userList = users
    }
    
    func onVideoListChange(change: DatabaseChange, videos: [Video]) {
        
    }
    
    func onPodcastListChange(change: DatabaseChange, podcasts: [Podcast]) {
        
    }
    
    
    var listenerType = ListenerType.users
    
    var userList: [User] = []
    var wantedUser = User()
    var gainedAccess = false
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var enteredUsername: String = ""
    var enteredPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gainedAccess = false
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        gainedAccess = false
        
        //make sure that the text fields are populated.
        if (usernameField.text != "" || passwordField.text != "")
        {
            enteredUsername = usernameField.text!
            enteredPassword = passwordField.text!
        }
        else
        {
            print("password and username field are empty")
            errorLabel.text = "password and username field are empty"
            errorLabel.isHidden = false
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
                
                gainedAccess = true
                errorLabel.isHidden = true
            }
            else
            {
                
                errorLabel.text = "The details you have entered do not match any of our records"
                errorLabel.isHidden = false
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
        //after validating the details, pass the desired user object to the next view controller.
        
        // Get the new view controller using segue.destination.
         let desiredScreen = segue.destination as! MainViewController
        // Pass the selected object to the new view controller.
        desiredScreen.user = wantedUser
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // override the should perform segue method to stop unauthorised access
        if (gainedAccess == false)
        {
            return false
        }
        else
        {
            // if the user details are good and match to a user allow them to pass into the next screen.
        return true
        }
    }
    

}
