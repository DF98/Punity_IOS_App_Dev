//
//  VideoViewController.swift
//  Punity
//
//  Created by Damian Farinaccio on 24/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit
import AVKit

class VideoViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let musicURL = URL(string: "https://audioboom.com/posts/7243055.mp3")
        let task = URLSession.shared.dataTask(with: musicURL!)
            self.finishedDownload = true
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.audioPlayer = try AVAudioPlayer(data: musicData!)
        }
        task.resume()
 
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
