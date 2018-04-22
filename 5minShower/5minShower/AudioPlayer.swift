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
    var audioArray = [URL]()
    var started = false
    var x = true
    var currentURL = URL(string: "")
    var index: Int!

    
    func playRandomFromArray() {
        print("rand")
        index = Int(arc4random_uniform(UInt32(audioArray.count)))
        self.play(url: audioArray[index])
    }
    
    func play(url: URL) {
        print("play")

        avPlayer = try! AVAudioPlayer(contentsOf: url)
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

        do {
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try! AVAudioSession.sharedInstance().setActive(true)
        }
        
        var song1 = URL(fileURLWithPath: Bundle.main.path(forResource: "df1", ofType: "mp3")!)
        var song2 = URL(fileURLWithPath: Bundle.main.path(forResource: "df2", ofType: "mp3")!)
        var song3 = URL(fileURLWithPath: Bundle.main.path(forResource: "df3", ofType: "mp3")!)
        var song4 = URL(fileURLWithPath: Bundle.main.path(forResource: "df4", ofType: "mp3")!)
        var song5 = URL(fileURLWithPath: Bundle.main.path(forResource: "df5", ofType: "mp3")!)
        var song6 = URL(fileURLWithPath: Bundle.main.path(forResource: "df6", ofType: "mp3")!)
        var song7 = URL(fileURLWithPath: Bundle.main.path(forResource: "df7", ofType: "mp3")!)
        var song8 = URL(fileURLWithPath: Bundle.main.path(forResource: "df8", ofType: "mp3")!)
        
        self.audioArray = [song1, song2, song3, song4, song5, song6, song7, song8]
    }
    
}

extension AudioPlayer : AVAudioPlayerDelegate {

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        print("swag")
        if index == audioArray.count - 1 {
            index = 0
        } else {
            index =  index + 1
        }
        currentURL = audioArray[index]
        play(url: currentURL!)
    }
}
