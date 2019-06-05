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
   
    
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    
        
        let videoURL = URL(string: "http://traffic.libsyn.com/joeroganexp/p1307.mp3?dest-id=19997")
        let player = AVPlayer(url: videoURL!)
        
        //sourced from https://www.iosapptemplates.com/blog/swift-programming/implement-rss-feed-parser-swift
        RSSParser.getRSSFeedResponse(path: "http://joeroganexp.joerogan.libsynpro.com/rss") { (rssFeed: RSSFeed?, status: NetworkResponseStatus) in
            print(rssFeed) // it will be nil if status == .error
        }
        
        
        
        //fulscreen mode
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
        /*
         Sub View Code
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.volume = 1.0
        player.play()
        */
    
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

