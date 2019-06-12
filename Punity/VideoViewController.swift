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
    var player: AVPlayer?
    //var audioPlayer = AVAudioPlayer()
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var audioSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
            player!.pause()
            playButton.setTitle("paused", for: UIControl.State.normal)
        }
        else {
            player!.play()
            playButton.setTitle("playing", for: UIControl.State.normal)
        }
    }
    
    
    //let duration : CMTime = player!.currentItem!.asset.duration
    //let seconds : Float64 = CMTimeGetSeconds(duration)
        
        //durationLabel.text = self.stringFromTimeInterval(interval: seconds)
        
        //let duration : CMTime = player!.currentTime()
        //let seconds : Float64 = CMTimeGetSeconds(duration)
        
        //currentTimeLabel.text = self.stringFromTimeInterval(interval: seconds)
    //}
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    
    
override func viewDidLoad() {
        super.viewDidLoad()
    
        titleLabel.text = video?.video_title
        descriptionTextView.text = video?.video_desc
        
       print(video?.video_link)
        
        let videoURL = URL(string: video!.video_link)!
        player = AVPlayer(url: videoURL)
        player?.volume = 1.0
        /*
        do {
        try audioPlayer = AVAudioPlayer(contentsOf: videoURL)
        } catch {
            print("Unable to Load Content :(")
        }
         */
 
        //audioSlider.maximumValue = Float(audioPlayer.duration)
        
        
        
        
        
        audioSlider.maximumValue = Float(CMTimeGetSeconds((player!.currentItem?.asset.duration)!))
        
    
        
        
        
        
        /*
        //fulscreen mode
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
         */
        
        //getting the duration of the audio and setting max value of the slider to the duration
        //audioSlider.maximumValue = TimeInterval(player?.currentItem?.duration)
        
        /*
         //Sub View Code
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player!.volume = 1.0
        player!.play()
        */
    
        //code from: https://stackoverflow.com/questions/25932570/how-to-play-video-with-avplayerviewcontroller-avkit-in-swift
    
        
/*
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
    
    func updateSlider() {
        audioSlider.value = Float(audioPlayer.currentTime)
    }
 
    

 /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 */
 */
    }
    
    
    @IBAction func handlePlayheadSliderTouchBegin(_ sender: UISlider) {
        player!.pause()
    }
    
    @IBAction func handlePlayheadSliderValueChanged(_ sender: UISlider) {
        
        let duration : CMTime = player!.currentItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration) * Double(sender.value)
        //   var newCurrentTime: TimeInterval = sender.value * CMTimeGetSeconds(currentPlayer.currentItem.duration)
        currentTimeLabel.text = self.stringFromTimeInterval(interval: seconds)
    }
    
    @IBAction func handlePlayheadSliderTouchEnd(_ sender: UISlider) {
        
        let duration : CMTime = player!.currentItem!.asset.duration
        var newCurrentTime: TimeInterval = Double(sender.value) * CMTimeGetSeconds(duration)
        var seekToTime: CMTime = CMTimeMakeWithSeconds(newCurrentTime, preferredTimescale: 600)
        player?.seek(to: seekToTime)
    }
    
    



}
