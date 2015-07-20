//
//  TimerController.swift
//  TimerFunctions
//
//  Created by Kiran Kunigiri on 7/14/15.
//  Copyright (c) 2015 Kiran Kunigiri. All rights reserved.
//

import Foundation
import UIKit

class TimerController: NSObject {
    // Time Properties
    var timer = NSTimer()
    var startTime = NSTimeInterval()
    
    // Audio Controlling
    var audioPlayer = AudioPlayer()
    
    // Properties of the label string
    var strHours = "00"
    var strMinutes = "0"
    var strSeconds = "00"
    var strFraction = "00"
    var isComplete = false
    
    var totalTime: NSTimeInterval = 100
    
    // Properties of actual values
    var hours = 0
    var minutes = 0
    var seconds = 0
    var fraction = 0
    
    var timeText = ""
    var label = UILabel()
    
    // MARK: Main Update Function
    func updateTime() {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //Set the elapsed time to the amount of time left in the timer
        
        var timeLeft = totalTime - elapsedTime
        
        if timeLeft <= 0 && isComplete == false {
            audioPlayer.playRandomFromArray()
            label.textColor = UIColor(red:0.86, green:0.27, blue:0.27, alpha:1.0)
            isComplete = true
        }
        
        //calculate the hours in elapsed time.
        
        hours = Int(timeLeft / 3600.0)
        
        timeLeft -= (NSTimeInterval(hours) * 3600)
        
        //calculate the minutes in elapsed time.
        
        minutes = Int(timeLeft / 60.0)
        var minutesLabel = minutes
        if minutesLabel < 0 {
            minutesLabel *= -1
        }
        
        timeLeft -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        seconds = Int(timeLeft)
        var secondsLabel = seconds
        if secondsLabel < 0 {
            secondsLabel *= -1
        }
        
        timeLeft -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        fraction = Int(timeLeft * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        strMinutes = String(format: "%01d", minutesLabel)
        strSeconds = String(format: "%02d", secondsLabel)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        label.text = "\(strMinutes):\(strSeconds)"
    }
    
    
    // MARK: Setting Functions
    func resetTimer() {
        startTime = NSDate.timeIntervalSinceReferenceDate()
        var strHours = "00"
        var strMinutes = "00"
        var strSeconds = "00"
        var strFraction = "00"
        var hours = 0
        var minutes = 0
        var seconds = 0
        var fraction = 0
        label.text = "\(strHours):\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
    func resetTimerWithNewTime(newTotalTime: NSTimeInterval) {
        self.totalTime = newTotalTime
        startTime = NSDate.timeIntervalSinceReferenceDate()
        var strHours = "00"
        var strMinutes = "00"
        var strSeconds = "00"
        var strFraction = "00"
        var hours = 0
        var minutes = 0
        var seconds = 0
        var fraction = 0
        label.text = "\(strMinutes):\(strSeconds)"
    }
    
    // MARK: Start/Stop Functions
    func start() {
        if !timer.valid {
            let aSelector: Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    func stop() {
        timer.invalidate()
        //resetTimer()
    }
    
    
    // MARK: Value Functions
    func getTimeLeft() -> NSTimeInterval {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        //Set the elapsed time to the amount of time left in the timer
        var timeLeft2 = totalTime - elapsedTime
        return timeLeft2
    }
    
    func getTimeComplete() -> NSTimeInterval {
        var timeLeft2 = getTimeLeft()
        var timeComplete = totalTime - timeLeft2
        
        return timeComplete
    }
    
    func getPercentageCompleted() -> Double {
        var timeLeft2 = getTimeLeft()
        var timeComplete = totalTime - timeLeft2
        var percent = (timeComplete/totalTime)
        
        return percent
    }
    
    
    
}
