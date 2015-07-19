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
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var volumeButton: UIButton!
    var volumeButtonSelected = false
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var waterSavedLabel: UILabel!
    @IBOutlet var shuffleButton: UIButton!
    
    // Animation vars
    var mainWaterController = WaterController()
    @IBOutlet weak var pcView: PCView!
    var wave = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopButton.hidden = true
        self.timerLabel.hidden = true
        self.volumeButton.hidden = true
        self.waterSavedLabel.hidden = true
        self.shuffleButton.hidden = true
        self.background.hidden = true
        self.doneButton.hidden = true
        
        timer.label = timerLabel
        
        
        // Setup Animations
        mainWaterController.view = self.view
        mainWaterController.showerView = pcView
        //self.view.bringSubviewToFront(pcView)
        
        setupWaves()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButtonTapped(sender: AnyObject) {
        println("playbuttontapped")
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
        
        // Animaion start code
        let timeInterval = NSTimeInterval (300)
        animateWave(timeInterval)
        mainWaterController.start()
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        println("done button tapped")
        
        self.stopButton.hidden = true
        self.timerLabel.hidden = true
        self.volumeButton.hidden = true
        self.waterSavedLabel.hidden = true
        self.shuffleButton.hidden = true
        self.background.hidden = true
        self.doneButton.hidden = true
        
        self.timer.resetTimer()
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
        self.doneButton.hidden = false
        
        if doubleTimeTaken < 300.0
        {
            self.waterSavedLabel.text = "Congratulations! You saved \(gallonsSaved) extra gallons!"
        }
        
        else
        {
            self.waterSavedLabel.text = "You went over the goal by \(gallonsSaved * -1) gallons. We know you can do better!"
        }
        UIView.animateWithDuration(3.0, animations: {
            self.waterSavedLabel.hidden = false
        })
        mainWaterController.stop()
    }
    
    // MARK: Animation Functions
    
    func setupWaves() {
        wave.image = UIImage(named: "Wave")
        var width = self.view.frame.width * 2.5
        var frame = CGRectMake(-10, self.view.frame.height, width, width * 0.8505)
        wave.frame = frame
        self.view.addSubview(wave)
        self.view.sendSubviewToBack(wave)
    }
    
    func animateWave(time: NSTimeInterval) {
        UIView.animateWithDuration(time, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.wave.frame.origin.y = 0
            }, completion: {
                (value: Bool) in
                self.mainWaterController.stop()
                println("STOP")
        })
    }
    
}
