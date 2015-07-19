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
    
    var intervalToTakeShower = NSTimeInterval()
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var volumeButton: UIButton!
    var volumeButtonSelected = false
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var waterSavedLabel: UILabel!
    @IBOutlet var shuffleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopButton.hidden = true
        self.timerLabel.hidden = true
        self.volumeButton.hidden = true
        self.waterSavedLabel.hidden = true
        self.shuffleButton.hidden = true
        self.background.hidden = true
        
        timer.label = timerLabel
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButtonTapped(sender: AnyObject) {
        music.shuffleMusic()
        music.playMusic()
        UIView.animateWithDuration(2.0, animations: {
            self.playButton.alpha = 0
            self.stopButton.alpha = 1
            self.timerLabel.alpha = 1
            self.stopButton.hidden = false
            self.timerLabel.hidden = false
            self.shuffleButton.hidden = false
            
        })
        self.playButton.hidden = true
        self.volumeButton.hidden = false
        
        timer.start()
    }
    
    @IBAction func shuffleButtonTapped(sender: AnyObject) {
        music.shuffleMusic()
        music.playMusic()
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
        
        let timeTaken = timer.getTimeComplete()
        let doubleTimeTaken = (Double)(timeTaken)
    
        timer.stop()
        let gallonsSaved = (Int)(2.1 * (300 - doubleTimeTaken) / 60 )
        
        UIView.animateWithDuration(2.0, animations: {
            self.volumeButton.alpha = 0
            self.timerLabel.alpha = 0
            self.stopButton.alpha = 0
            self.shuffleButton.alpha = 0
        })
        
        self.volumeButton.hidden = true
        self.timerLabel.hidden = true
        self.stopButton.hidden = true
        self.shuffleButton.hidden = true
        self.background.hidden = false
        
        if doubleTimeTaken < 300.0
        {
            self.waterSavedLabel.text = "Congratulations! You saved \(gallonsSaved) extra gallons!"
        }
        
        else
        {
            self.waterSavedLabel.text = "You went over the goal by \(gallonsSaved * -1). We know you can do better!"
        }
        
        self.waterSavedLabel.hidden = false
    }
    
}
