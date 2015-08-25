//
//  AudioPlayer.swift
//  AWESOME
//
//  Created by Kiran Kunigiri on 7/19/15.
//  Copyright (c) 2015 Kiran Kunigiri. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer: NSObject {
    // Properties
    var avPlayer = AVAudioPlayer()
    var audioArray: [NSURL] = []
    var started = false
    var x = true
    var currentURL = NSURL()
    var index:Int!

    
    func playRandomFromArray() {
        println("rand")
        index = Int(arc4random_uniform(UInt32(audioArray.count)))
        self.play(audioArray[index])
        
       
    }
    
    func play(url: NSURL) {
        println("play")
        var error:NSError?
        
        avPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        avPlayer.prepareToPlay()
        avPlayer.delegate = self
        avPlayer.play()
        started = true
    }
    
    
    func pauseClip() {
        if started {
            avPlayer.pause()
        }
    }
    
    func setup() {
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var song1 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("df1", ofType: "mp3")!)
        var song2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("df2", ofType: "mp3")!)
        var song3 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("df3", ofType: "mp3")!)
        var song4 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("df4", ofType: "mp3")!)
        var song5 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("df5", ofType: "mp3")!)
        var song6 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("df6", ofType: "mp3")!)
        var song7 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("df7", ofType: "mp3")!)
        var song8 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("df8", ofType: "mp3")!)
        
        self.audioArray = [song1!, song2!, song3!, song4!, song5!, song6!, song6!, song7!, song8!]
    }
    
}

extension AudioPlayer : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("swag")
        if index == audioArray.count - 1 {
            index = 0
        } else {
            index =  index + 1
        }
        currentURL = audioArray[index]
        play(currentURL)
    }
}