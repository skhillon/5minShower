//
//  AudioPlayer.swift
//  AWESOME
//
//  Created by Kiran Kunigiri on 7/19/15.
//  Copyright (c) 2015 Kiran Kunigiri. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer {
    // Properties
    var audioPlayer = AVAudioPlayer()
    var audioArray: [NSURL] = []
    var started = false
    
    func playRandomFromArray() {
        var index = Int(arc4random_uniform(UInt32(audioArray.count)))
        var currentURL = audioArray[index]
        self.play(currentURL)
    }
    
    func play(url: NSURL) {
        var alertSound = url
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        started = true
    }
    
    func pause() {
        if started {
            audioPlayer.pause()
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