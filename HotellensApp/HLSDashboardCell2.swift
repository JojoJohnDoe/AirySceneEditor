//
//  HLSDashboardCell2.swift
//  HotellensApp
//
//  Created by Johannes Karow on 16/09/14.
//  Copyright (c) 2014 Hotellens. All rights reserved.
//

import Foundation
import UIKit

class Bar:UIView
{
    override func drawRect(rect: CGRect) {
        self.backgroundColor = UIColor.purpleColor()
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, UIColor.grayColor().CGColor)
        CGContextSetLineWidth(context, 10.0);
        var barMinX = 0 as CGFloat
        var barMaxX = self.bounds.width
        CGContextMoveToPoint(context, barMinX, self.bounds.height/2);
        CGContextAddLineToPoint(context, barMaxX, self.bounds.height/2);
        CGContextDrawPath(context, kCGPathStroke);
    }
}
class Bar2:UIView
{
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetLineWidth(context, 10.0);
        var barMinX = self.bounds.width/2
        var barMaxX = self.bounds.width/2
        CGContextMoveToPoint(context, barMinX, 0.0);
        CGContextAddLineToPoint(context, barMaxX, self.bounds.height);
        CGContextDrawPath(context, kCGPathStroke);
    }
}

class HLSDashboardCell2: UITableViewCell
{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dailyrateBar: UIView!
    /*override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
    println("Ente")
    super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }*/
    
    // Testsektion zum rendern der einzeinen Zellen eventuell noch in einzelne Files auslagern!!
    
    // MARK: Draw DailyRateBar
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
    }
    
    
    
    func drawDailyRate() {
        // Drawing the vertical line
        
        //only our background for testing purposes
        self.dailyrateBar.backgroundColor = UIColor.blueColor()
        
        var view = Bar(frame: self.dailyrateBar.bounds)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.backgroundColor = UIColor.clearColor()
        self.dailyrateBar.addSubview(view)
        
        var view2 = Bar2(frame: self.dailyrateBar.bounds)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view2.backgroundColor = UIColor.clearColor()
        self.dailyrateBar.addSubview(view2)
        
        
        self.dailyrateBar.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["view":view]))
        self.dailyrateBar.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["view":view]))
        
        self.dailyrateBar.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view2]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["view2":view2]))
        self.dailyrateBar.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view2]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["view2":view2]))
        
        self.needsUpdateConstraints()
        self.setNeedsDisplay()
        view.setNeedsDisplay()
        
    
    /*    
        
        
        
        
        mask.frame = view.layer.bounds
        //        mask.frame = bounds2
        
        let width = self.dailyrateBar.layer.frame.size.width
        let height = self.dailyrateBar.layer.frame.size.height
        //        let width = CGFloat(10.0)
        //        let height = CGFloat(10.0)
        
        var dailyBar = CGPathCreateMutable()
        //var dailyBarIndicator = CGPathCreateMutable()
        
        CGPathMoveToPoint(dailyBar, nil, 0, height/2)
        CGPathAddLineToPoint(dailyBar, nil, width, height/2)
        CGPathAddLineToPoint(dailyBar, nil, width, (height/2)-3)
        CGPathAddLineToPoint(dailyBar, nil, 0, (height/2)-3)
        CGPathAddLineToPoint(dailyBar, nil, 0, height/2)
        
        CGPathMoveToPoint(dailyBar, nil, width/2.5, height/2-3)
        CGPathAddLineToPoint(dailyBar, nil, width/2.5, height/2+5)
        CGPathAddLineToPoint(dailyBar, nil, width/2.5+1, height/2+5)
        CGPathAddLineToPoint(dailyBar, nil, width/2.5+1, height/2-3)
        CGPathAddLineToPoint(dailyBar, nil, width/2.5, height/2-3)
        
        
        //mask.path = dailyBarIndicator
        mask.path = dailyBar
        
        view.layer.mask = mask
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        var shape = CAShapeLayer()
        shape.frame = self.bounds
        shape.path = path
        shape.lineWidth = 3.0
        shape.strokeColor = UIColor.whiteColor().CGColor
        shape.fillColor = UIColor.clearColor().CGColor
        
        self.layer.insertSublayer(shape, atIndex: 0)*/
        
        // MARK: -------- constraints-------
        //make dictionary for views
        //let viewsDictionary = ["view1":view1,"view2":view2]
        
        
        // Setup our context
        /*let barsize = CGSize(width: self.dailyrateBar.bounds.size.width, height: 90)
        let bounds = CGRect(origin: CGPoint.zeroPoint, size: barsize)
        let opaque = false
        let scale: CGFloat = 0
        
        UIGraphicsBeginImageContextWithOptions(barsize, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetLineWidth(context, 2.0)
        
        CGContextStrokeRect(context, bounds)
        
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, CGRectGetMinX(bounds), CGRectGetMinY(bounds))
        CGContextAddLineToPoint(context, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds))
        CGContextMoveToPoint(context, CGRectGetMaxX(bounds), CGRectGetMinY(bounds))
        CGContextAddLineToPoint(context, CGRectGetMinX(bounds), CGRectGetMaxY(bounds))
        CGContextStrokePath(context)
        
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.dailyrateBar.addSubview(UIImageView(image: image))
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        self.dailyrateBar.setNeedsUpdateConstraints()*/
        
        
        /*let ctx = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0)
        CGContextSetLineWidth(ctx, 0.75)
        for f in cell.columns {
        let f = self.columns[i] as? float // Error - Use of module 'float' as a type
        CGContextMoveToPoint(ctx, f, 10)
        CGContextAddLineToPoint(ctx, f, self.bounds.size.height - 10)
        }
        CGContextStrokePath(ctx)*/
    }

    
}