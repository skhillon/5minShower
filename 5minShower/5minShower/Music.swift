//
//  Music.swift
//  5minShower
//
//  Created by Laikh Tewari on 7/18/15.
//  Copyright (c) 2015 5minShower. All rights reserved.
//

import UIKit
import MediaPlayer

class Music: NSObject {
//    let myMusicPlayer = MPMusicPlayerController()
//    let myMediaQuery = MPMediaQuery()
//    
//    @IBAction func playButtonTapped(sender: AnyObject) {
//        println ("play button tapped")
//        myMusicPlayer.setQueueWithQuery(myMediaQuery)
//        myMusicPlayer.play()
//        UIView.animateWithDuration(2.0, animations: {
//            self.playButton.alpha = 0
//            self.stopButton.alpha = 1
//            self.stopButton.hidden = false
//        })
//        self.playButton.hidden = true
//        
//        timer.start()
//    }
//    
//    @IBAction func stopButtonTapped(sender: AnyObject) {
//        stop()
//    }
//    
//    func stop ()
//    {
//        myMusicPlayer.pause()
//        timer.stop()
//    }
    
    let myMusicPlayer = MPMusicPlayerController()
    let myMediaQuery = MPMediaQuery()
    
    func playMusic ()
    {
        myMusicPlayer.setQueueWithQuery(myMediaQuery)
        myMusicPlayer.shuffleMode = MPMusicShuffleMode (rawValue: 3)! 
        myMusicPlayer.play()
    }
    
    func stop ()
    {
        myMusicPlayer.pause()
    }
}
