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
    override func drawRect(rect: CGRect) {
        // Drawing code
        var width = self.frame.width * 0.55
        //0.77551156435
        //0.82870092648
        var height = 0.77666666666 * width
        
        var x = self.frame.width/2 - width/2 + (1/8.9) * self.frame.width
        var y = self.frame.height * 0.04
        MyStyleKit.drawShower(frame: CGRectMake(x, y, width, height))
        
//        var rectangle = UIView()
//        rectangle.frame = CGRectMake(self.frame.width/2, y, 10, 100)
//        rectangle.backgroundColor = UIColor.blackColor()
//        self.addSubview(rectangle)
    }

}