//
//  MainViewController.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/6/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class MainViewController: ViewController {

    var user: User?
    
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        welcomeLabel.text = "Hi, \(user!.username)"
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if (segue.identifier == "main_profile_segue")
        {
            let destination = segue.destination as! ProfileViewController
            destination.user = self.user
            
        }
        // Pass the selected object to the new view controller.
    }
    

}
