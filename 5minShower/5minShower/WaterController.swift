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
    
    //create var for start pos of rain (startX,startY), and distances between drops w/ meaningless values
    var startX = CGFloat(100)
    var startY = CGFloat(175)
    var distanceBetweenEachDrop = CGFloat(18)
    var distanceBetweenSameRow = CGFloat(50)
    
    //create light blue color for rain drops
    var dropColor = UIColor(red:0.56, green:0.76, blue:0.85, alpha:1.0)
    //initialize the gravity object and UIView
    var gravityBehavior = UIGravityBehavior()
    var showerView = UIView()
    //creat vars for timers for the 2 rows of rain drops
    var timer1 = Timer()
    var timer2 = Timer()
    
    func start() {
        // Setup the class
        
        //var for screen width
        var width = self.view.frame.width
        
        // Initialize Values for Position of raindrops and space between them
        startX = CGFloat(width * 0.425)
        startY = CGFloat(width * 0.23)
        distanceBetweenEachDrop = width * 0.048
        distanceBetweenSameRow = distanceBetweenEachDrop * 2
        
        // Initialize animator
        self.animator = UIDynamicAnimator(referenceView: self.view)
        gravityBehavior.gravityDirection.dy = 1
        self.animator.addBehavior(gravityBehavior)
        
        //timer that calls spawnFirst method every 0.2 second. Produces rain drops every .2 second in 1st and 2rd row
        timer1 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(spawnFirst), userInfo: nil, repeats: true)
        var tempTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startSecond), userInfo: nil, repeats: false)
    }
    
    @objc func startSecond() {
        //calls spawnSecond method every .2 seconds. Produces rain drops every .2 seconds
        timer2 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: "spawnSecond", userInfo: nil, repeats: true)
    }
    
    func addGravity(array: [UIView]) {
        //adds gravity to every drop in array
        for drop in array {
            gravityBehavior.addItem(drop)
        }
        //Checks if each drop is below the bottom of screen. Then removes its gravity, hides it, and removes from array
        for i in 0..<drops.count {
            if drops[i].frame.origin.y > self.view.frame.height {
                gravityBehavior.removeItem(drops[i])
                drops[i].removeFromSuperview()
                drops.remove(at: i)
            }
        }
    }
    
    //produces the 1st and 3rd columns of drops
    @objc func spawnFirst() {
        //creates array of UIViews (drops)
        var thisArray: [UIView]? = []
        //number of col of drops
        var numberOfDrops = 2
        //for each drop in a row
        for i in 0..<numberOfDrops {
            //create a UIView (a drop). Then set the size, color, and remove border of drop
            var drop = UIView()
            drop.frame = CGRect(x: startX + CGFloat(i) * distanceBetweenSameRow, y: startY, width: 1.0, height: 50.0)
            drop.backgroundColor = dropColor
            drop.layer.borderWidth = 0.0
            //add the drop to main view
            self.view.insertSubview(drop, belowSubview: showerView)
            //add the drop to the drops array
            self.drops.append(drop)
            //add the drop to thisArray
            thisArray!.append(drop)
        }
        //adds gravity to the drops that were just created
        addGravity(array: thisArray!)
    }
    
    //produces the 2nd and 4th columns of drops. Same code as spawnFirst. Runs .1 after spawnFirst.
    func spawnSecond() {
        var thisArray: [UIView] = []
        var numberOfDrops = 2
        
        for i in 0..<numberOfDrops {
            var location = CGFloat(150)
            
            var drop = UIView()
            drop.frame = CGRect(x: startX + distanceBetweenEachDrop + CGFloat(i) * distanceBetweenSameRow, y: startY, width: CGFloat(1.0), height: CGFloat(50.0))
            drop.backgroundColor = dropColor
            drop.layer.borderWidth = 0.0
            self.view.insertSubview(drop, belowSubview: showerView)
            self.drops.append(drop)
            thisArray.append(drop)
        }
        
        addGravity(array: thisArray)
    }
    
    func stop() {
        //removes all objects from drops array
        drops = []
        //stops the 2 timers from spawning drops.
        timer1.invalidate()
        timer2.invalidate()
    }
    
}
