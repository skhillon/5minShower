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
    
    let myMusicPlayer = MPMusicPlayerController()
    let myMediaQuery = MPMediaQuery()
    
    func shuffleMusic ()
    {
        myMusicPlayer.setQueue(with: myMediaQuery)
        myMusicPlayer.shuffleMode = MPMusicShuffleMode (rawValue: 3)!
    }
    func playMusic ()
    {
        myMusicPlayer.play()
    }
    
    func stop ()
    {
        myMusicPlayer.pause()
    }
}
