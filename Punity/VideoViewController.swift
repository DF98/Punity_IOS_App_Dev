//
//  VideoViewController.swift
//  Punity
//
//  Created by Damian Farinaccio on 24/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

//custom audio controls https://stackoverflow.com/questions/43062870/add-custom-controls-to-avplayer-in-swift

import UIKit
import AVFoundation
import AVKit
import Alamofire
import AlamofireRSSParser

class VideoViewController: UIViewController  {
 
    var video: Video?
    var player: AVPlayer?
    var timer: Timer?
    
    //var backgroundAudio: AVAudioPlayer?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        //timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        
        titleLabel.text = video?.video_title
        descriptionTextView.text = video?.video_desc
        
        print(video?.video_link)
        
        /*
        let videoURL = URL(string: video!.video_link)!
        
        if(video?.video_link != "")
        {
        let videoNSURL = NSURL(string: (video?.video_link)!)
        }
        else
        {
            print("episode could not be played :( ")
        }
        
        do{
        try backgroundAudio = AVAudioPlayer(contentsOf: videoURL)
        } catch {
            print("error getting video")
        }
        */
        
        if (video!.video_link != "")
        {
        let videoURL = URL(string: video!.video_link)!
        player = AVPlayer(url: videoURL)
        player?.volume = 1.0
        }
        /*
        let duration : CMTime = (player?.currentItem!.asset.duration)!
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        slider.maximumValue = Float((player!.currentItem?.asset.duration.seconds)!)
        print("slider max value: \(slider.maximumValue)")
        durationLabel.text = self.stringFromTimeInterval(interval: seconds)
        
        let currentTime : CMTime = player!.currentTime()
        let currentTimeSeconds : Float64 = CMTimeGetSeconds(currentTime)
        
        currentTimeLabel.text = self.stringFromTimeInterval(interval: currentTimeSeconds)
        */
        
        /*
        do {
        try audioPlayer = AVAudioPlayer(contentsOf: videoURL)
        } catch {
            print("Unable to Load Content :(")
        }
         */
 
        //audioSlider.maximumValue = Float(audioPlayer.duration)
        

        
      
        
        
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 */
 
    }
    
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        //purpose of this method is when the start listening button is pressed we redirect to avplayer view controller to play the audio and provide interactive audio controls.
        
        //if statement is to prevent app from crashing.
        //code from: https://stackoverflow.com/questions/25932570/how-to-play-video-with-avplayerviewcontroller-avkit-in-swift
        if (video?.video_link != "")
        {
            //fulscreen mode
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
            
        else
        {
            //if there is no video link display an error message.
            errorLabel.text = "This episode could not be played."
            errorLabel.isHidden = false
        }
    }
    
    
    /*
     //this code was an attempt to add customised audio controls that would assist me in making clips later on.
     
    @objc func updateSlider()
    {
        /*
        if(slider.isSelected == false)
         {
        slider.value = Float((player?.currentTime().seconds)!)
        
        let currentTime : CMTime = player!.currentTime()
        let currentTimeSeconds : Float64 = CMTimeGetSeconds(currentTime)
        
        currentTimeLabel.text = self.stringFromTimeInterval(interval: currentTimeSeconds)
        }
         */
    }

    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
        if(backgroundAudio?.isPlaying == true)
        {
            backgroundAudio?.stop()
            playButton.setTitle("Play", for: .normal)
        }
        else
        {
            backgroundAudio?.play()
            playButton.setTitle("Pause", for: .normal)
        }
        
        
        if sender.isSelected == true {
            sender.isSelected = false
        }
        if sender.isSelected == false{
            sender.isSelected = true
        }
 
 
        if sender.isSelected {
            player!.pause()
            sender.isSelected = false
        }
        else {
            player!.play()
            sender.isSelected = true
            
        }
 
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    
    @IBAction func handlePlayHeadSliderTouchBegin(_ sender: UISlider) {
        //player!.pause()
    }
    
    @IBAction func handlePlayHeadSliderValueChanged(_ sender: UISlider) {
        /*
        let sliderValue = slider.value
        let newCurrentTime : CMTime = CMTimeMakeWithSeconds(Float64(sliderValue), preferredTimescale: 0)
        player!.seek(to: newCurrentTime)
        currentTimeLabel.text = self.stringFromTimeInterval(interval: newCurrentTime.seconds)
         */
        
        /*
        let duration : CMTime = (player?.currentItem!.asset.duration)!
        let seconds : Float64 = CMTimeGetSeconds(duration) * Double(sender.value)
        //var newCurrentTime: TimeInterval = sender.value * CMTimeGetSeconds(player!.currentItem!.duration)
        currentTimeLabel.text = self.stringFromTimeInterval(interval: seconds)
         */
        
    }
    
    @IBAction func handlePlaySliderTouchEnd(_ sender: UISlider) {
        backgroundAudio?.stop()
        backgroundAudio?.currentTime = TimeInterval(slider.value)
        backgroundAudio?.prepareToPlay()
        backgroundAudio?.play()
        
        /*
        let sliderValue = slider.value
        let newCurrentTime : CMTime = CMTimeMakeWithSeconds(Float64(sliderValue), preferredTimescale: 0)
        player!.seek(to: newCurrentTime)
         */
        
        /*
        let duration : CMTime = (player?.currentItem!.asset.duration)!
        var newCurrentTime: TimeInterval = Double(sender.value) * CMTimeGetSeconds(duration)
        var seekToTime: CMTime = CMTimeMakeWithSeconds(newCurrentTime, preferredTimescale: 600)
        player!.seek(to: seekToTime)
        player!.play()
         */
    }
    
   */

}
