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
    
    var intervalToTakeShower = TimeInterval()
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var volumeButton: UIButton!
    var volumeButtonSelected = false
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var waterSavedLabel: UILabel!
    @IBOutlet var shuffleButton: UIButton!
    
    var waveTimer = Timer()
    
    // Animation vars
    var mainWaterController = WaterController()
    @IBOutlet weak var pcView: PCView!
    var wave = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopButton.isHidden = true
        self.timerLabel.isHidden = true
        self.volumeButton.isHidden = true
        self.waterSavedLabel.isHidden = true
        self.shuffleButton.isHidden = true
        self.background.isHidden = true
        self.doneButton.isHidden = true
        
        timer.label = timerLabel
        
        // Setup Animations
        mainWaterController.view = self.view
        mainWaterController.showerView = pcView
        //self.view.bringSubviewToFront(pcView)
        
        setupWaves()
        
        timer.audioPlayer.setup()
        waveTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animateWave), userInfo: nil, repeats: true)
    }
    
    @IBAction func playButtonTapped(sender: AnyObject) {
        print("playbuttontapped")
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        music.shuffleMusic()
        music.playMusic()
        UIView.animate(withDuration: 2.0, animations: {
            self.playButton.alpha = 0
            self.stopButton.alpha = 1
            self.timerLabel.alpha = 1
            self.stopButton.isHidden = false
            self.timerLabel.isHidden = false
            self.volumeButton.isHidden = false
            self.volumeButton.alpha = 1
            self.shuffleButton.isHidden = false
            self.shuffleButton.alpha = 1
            
        })
        self.playButton.isHidden = true
        self.volumeButton.isHidden = false
        self.timerLabel.textColor = UIColor.black

        timer.start()
        
        // Animaion start code
        let timeInterval = TimeInterval(300)
        mainWaterController.start()
        
        setupWaves()
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        resetView()
    }
    
    @IBAction func shuffleButtonTapped(sender: AnyObject) {
        music.shuffleMusic()
        music.playMusic()
    }
    @IBAction func volumeButtonTapped(sender: AnyObject) {
        self.volumeButton.isSelected = !volumeButtonSelected
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
        
        UIApplication.shared.isIdleTimerDisabled = false
        
        let timeTaken = timer.getTimeComplete()
        let doubleTimeTaken = (Double)(timeTaken)
        timer.stop()
        let gallonsSaved = (Int)(2.1 * (300 - doubleTimeTaken) / 60 )
        
        var waterSavedLabelText = "Congratulations! You saved \(gallonsSaved) extra gallons!"
        if timer.isComplete {
            waterSavedLabelText = "Wow. You went over 5 minutes and wasted a lot of water!"
        }
        
        UIView.animate(withDuration: 2.0, animations: {
            self.volumeButton.alpha = 0
            self.timerLabel.alpha = 0
            self.stopButton.alpha = 0
            self.shuffleButton.alpha = 0
        })
        
        self.volumeButton.isHidden = true
        self.timerLabel.isHidden = true
        self.stopButton.isHidden = true
        self.shuffleButton.isHidden = true
        self.background.isHidden = false
        self.doneButton.isHidden = false
        self.wave.isHidden = true
        
        if doubleTimeTaken < 300.0 {
            self.waterSavedLabel.alpha = 0
            UIView.animate(withDuration: 1.0, animations: {
                self.waterSavedLabel.text = waterSavedLabelText
                self.waterSavedLabel.alpha = 1
            })
        } else {
            self.waterSavedLabel.alpha = 0
            UIView.animate(withDuration: 1.0, animations: {
                self.waterSavedLabel.text = "You went over the goal by \(gallonsSaved * -1) gallons. We know you can do better!"
                self.waterSavedLabel.alpha = 1
            })
        }
        
        UIView.animate(withDuration: 3.0, animations: {
            self.waterSavedLabel.isHidden = false
        })
        mainWaterController.stop()
        
        timer.audioPlayer.pauseClip()
    }
    
    // MARK: Animation Functions
    
    func setupWaves() {
        wave.image = UIImage(named: "Wave")
        var width = self.view.frame.width * 2.5
        var frame = CGRect(x: -10, y: self.view.frame.height, width: width, height: width * 0.8505)
        wave.frame = frame
        wave.removeFromSuperview()
        wave.alpha = 1
        wave.isHidden = false
        self.view.addSubview(wave)
        self.view.sendSubview(toBack: wave)
    }
    
    @objc func animateWave() {
        // Move the wave based on the timer percentage completed
        if (timer.getPercentageCompleted() <= 1) {
            self.wave.frame.origin.y = CGFloat(1.0 - timer.getPercentageCompleted()) * self.view.frame.height
        }
        if timer.isComplete {
            UIView.animate(withDuration: 5.0, animations: {
                self.volumeButton.alpha = 0
                self.shuffleButton.alpha = 0
                }, completion: { _ in
                    self.volumeButton.isHidden = true
                    self.shuffleButton.isHidden = true
            })
        }
    }
    
    func resetView() {
        print("done button tapped")
        
        self.playButton.alpha = 1
        self.playButton.isHidden = false
        self.stopButton.isHidden = true
        self.timerLabel.isHidden = true
        self.volumeButton.isHidden = true
        self.waterSavedLabel.isHidden = true
        self.shuffleButton.isHidden = true
        self.background.isHidden = true
        self.doneButton.isHidden = true
        self.playButton.isHidden = false
        
        self.timer.resetTimer()
        timer.isComplete = false
    }
    
}
