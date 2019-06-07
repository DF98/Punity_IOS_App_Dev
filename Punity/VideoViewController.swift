//
//  VideoViewController.swift
//  Punity
//
//  Created by Damian Farinaccio on 24/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Alamofire
import AlamofireRSSParser

class VideoViewController: UIViewController  {
    //var player: AVAudioPlayer?
   
    var video: Video?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        titleLabel.text = video?.video_title
        descriptionTextView.text = video?.video_desc
    
        
        let videoURL = URL(string: video!.video_link)
        
        let player = AVPlayer(url: videoURL!)
        
        
        /*
        //fulscreen mode
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
         */
        
        
         //Sub View Code
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.volume = 1.0
        player.play()
        
    
        //code from: https://stackoverflow.com/questions/25932570/how-to-play-video-with-avplayerviewcontroller-avkit-in-swift
    
        
        
        // Do any additional setup after loading the view.
        /*
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
 */
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

