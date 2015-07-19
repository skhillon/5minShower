//
//  ViewController.swift
//  5minShower
//
//  Created by Saagar Godithi on 7/18/15.
//  Copyright (c) 2015 5minShower. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = TimerController()
    var music = Music()
    
    @IBOutlet weak var volumeButton: UIButton!
    var volumeButtonSelected = false
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopButton.hidden = true
        self.timerLabel.hidden = true
        self.volumeButton.hidden = true
        self.stopButton.alpha = 0
        self.timerLabel.alpha = 0
        
        timer.label = timerLabel
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButtonTapped(sender: AnyObject) {
        music.playMusic()
        UIView.animateWithDuration(2.0, animations: {
            self.playButton.alpha = 0
            self.stopButton.alpha = 1
            self.timerLabel.alpha = 1
            self.stopButton.hidden = false
            self.timerLabel.hidden = false
        })
        self.playButton.hidden = true
        self.volumeButton.hidden = false
                    
        timer.start()
    }
    
    @IBAction func volumeButtonTapped(sender: AnyObject) {
        self.volumeButton.selected = !volumeButtonSelected
        volumeButtonSelected = !volumeButtonSelected
        if volumeButtonSelected
        {
            music.stop()
        }
        else
        {
            music.playMusic()
        }
    }
    
    @IBAction func stopButtonTapped(sender: AnyObject) {
        music.stop()
        timer.stop()
    }
    
}
