//
//  WaterController.swift
//  Physics
//
//  Created by Kiran Kunigiri on 7/18/15.
//  Copyright (c) 2015 Kiran Kunigiri. All rights reserved.
//

import Foundation
import UIKit

class WaterController: NSObject {
    
    var view: UIView = UIView()
    var animator = UIDynamicAnimator()
    var drops: [UIView] = []
    var startX = CGFloat(100)
    var startY = CGFloat(175)
    var distanceBetweenEachDrop = CGFloat(18)
    var distanceBetweenSameRow = CGFloat(50)
    var dropColor = UIColor(red:0.56, green:0.76, blue:0.85, alpha:1.0)
    var gravityBehavior = UIGravityBehavior()
    var showerView = UIView()
    
    var timer1 = NSTimer()
    var timer2 = NSTimer()
    
    func start() {
        // Setup the class
        timer1 = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "spawnFirst", userInfo: nil, repeats: true)
        var tempTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startSecond", userInfo: nil, repeats: false)
        
        // Initialize animator
        self.animator = UIDynamicAnimator(referenceView: self.view)
        gravityBehavior.gravityDirection.dy = 1
        self.animator.addBehavior(gravityBehavior)
        
        // Initialize Values
        distanceBetweenEachDrop = self.view.frame.width * 0.048
        var width = self.view.frame.width * 0.5
        var x = self.view.frame.width/2 - width/2 + (1/8.9) * self.view.frame.width
        distanceBetweenSameRow = distanceBetweenEachDrop * 2
        startX = CGFloat(x + self.view.frame.width/26)
        var height = 0.56 * width
        startY = CGFloat(height)
    }
    
    func startSecond() {
        timer2 = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "spawnSecond", userInfo: nil, repeats: true)
    }
    
    func addGravity(array: [UIView]) {
        for drop in array {
            gravityBehavior.addItem(drop)
        }

        for var i = 0; i < drops.count; i++ {
            if drops[i].frame.origin.y > self.view.frame.height {
                gravityBehavior.removeItem(drops[i])
                drops[i].removeFromSuperview()
                drops.removeAtIndex(i)
            }
        }
    }
    
    func spawnFirst() {
        var thisArray: [UIView]? = []
        var numberOfDrops = 2
        
        for (var i = 0; i < numberOfDrops; i++) {
            var drop = UIView()
            drop.frame = CGRectMake(startX + CGFloat(i) * distanceBetweenSameRow, startY, 1.0, 50.0)
            drop.backgroundColor = dropColor
            drop.layer.borderWidth = 0.0
            self.view.insertSubview(drop, belowSubview: showerView)
            self.drops.append(drop)
            thisArray!.append(drop)
        }
        
        addGravity(thisArray!)
    }
    
    func spawnSecond() {
        var thisArray: [UIView] = []
        var numberOfDrops = 2
        
        for (var i = 0; i < numberOfDrops; i++) {
            var location = CGFloat(150)
            
            var drop = UIView()
            drop.frame = CGRectMake(startX + distanceBetweenEachDrop + CGFloat(i) * distanceBetweenSameRow, startY, 1.0, 50.0)
            drop.backgroundColor = dropColor
            drop.layer.borderWidth = 0.0
            self.view.insertSubview(drop, belowSubview: showerView)
            self.drops.append(drop)
            thisArray.append(drop)
        }
        
        addGravity(thisArray)
    }
    
    func stop() {
        drops = []
        timer1.invalidate()
        timer2.invalidate()
    }
    
}