//
//  ViewController.swift
//  5minShower
//
//  Created by Saagar Godithi on 7/18/15.
//  Copyright (c) 2015 5minShower. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let myMusicPlayer = MPMusicPlayerController()
    let myMediaQuery = MPMediaQuery()
    
    @IBAction func playButtonTapped(sender: AnyObject) {
        myMusicPlayer.setQueueWithQuery(myMediaQuery)
        myMusicPlayer.play()
    }
    
    @IBAction func pauseButtonTapped(sender: AnyObject) {
        stop()
    }
    
    func stop ()
    {
        myMusicPlayer.pause()
    }
}
