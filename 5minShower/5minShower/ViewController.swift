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
    
    
    
    @IBOutlet weak var volumeButton: UIButton!
    var volumeButtonSelected = false
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var waterSavedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopButton.hidden = true
        self.timerLabel.hidden = true
        self.volumeButton.hidden = true
        self.waterSavedLabel.hidden = true
        
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
        
        let timeTaken = timer.getTimeComplete()
        let doubleTimeTaken = (Double)(timeTaken)
    
        timer.stop()
        let gallonsSaved = (Int)(2.1 * (5 - doubleTimeTaken))
        
        self.volumeButton.hidden = true
        self.timerLabel.hidden = true
        self.stopButton.hidden = true
        
        if doubleTimeTaken < 5.0
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
