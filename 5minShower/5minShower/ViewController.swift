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
    
    var timer = TimerController()
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    //@IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopButton.hidden = true
        self.stopButton.alpha = 0
        
        timer.label = timerLabel
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let myMusicPlayer = MPMusicPlayerController()
    let myMediaQuery = MPMediaQuery()
    
    @IBAction func playButtonTapped(sender: AnyObject) {
        println ("play button tapped")
        myMusicPlayer.setQueueWithQuery(myMediaQuery)
        myMusicPlayer.play()
        UIView.animateWithDuration(2.0, animations: {
            self.playButton.alpha = 0
            self.stopButton.alpha = 1
            self.stopButton.hidden = false
        })
        self.playButton.hidden = true
        
        timer.start()
    }
    
    @IBAction func stopButtonTapped(sender: AnyObject) {
        stop()
    }
    
    func stop ()
    {
        myMusicPlayer.pause()
        timer.stop()
    }
    
}
