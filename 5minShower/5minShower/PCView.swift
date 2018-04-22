//
//  PCView.swift
//  PaintcodeTest
//
//  Created by Kiran Kunigiri on 7/18/15.
//  Copyright (c) 2015 Kiran Kunigiri. All rights reserved.
//

import UIKit

class PCView: UIView {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code for showerhead
        
        var frameWidth = self.frame.width
        
        //width of showerhead. Streches right side of ShowerHead
        var width = frameWidth * 0.48
        //height of showerhead. Streches bottom side of ShowerHead
        var height = 0.77666666666 * width
        
        //Origin of showerhead (at top left)
        var x = frameWidth/2 - width/2 + (1/8.6) * frameWidth
        var y = frameWidth * 0.05
        
        //draw showerhead
        MyStyleKit.drawShower(frame: CGRect(x: x, y: y, width: width, height: height))        
    }
    
}
