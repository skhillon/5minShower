//
//  ViewController.swift
//  5minShower
//
//  Created by Saagar Godithi on 7/18/15.
//  Copyright (c) 2015 5minShower. All rights reserved.
//

import UIKit
import MediaPlayer
import Foundation


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    var notificationCenter: NSNotificationCenter = defaultCenter()
//    
//    notificationCenter.addObserver = self
//    notificationCenter.selector(handle_NowPlayingItemChanged)
    
    var appMusicPlayer: MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer()

    enum MPMusicShuffleMode : Int {
        case Default
        case Off
        case Songs
        case Albums
    }
    
    appMusicPlayer = MPMusicShuffleMode.Songs
   
    
}




