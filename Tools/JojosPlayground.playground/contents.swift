// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//// General Declarations
let context = UIGraphicsGetCurrentContext()

//// Color Declarations
let color = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)

//// Rectangle Drawing
CGContextSaveGState(context)
CGContextTranslateCTM(context, 10, 5.81)
CGContextRotateCTM(context, -45 * CGFloat(M_PI) / 180)

let rectanglePath = UIBezierPath(rect: CGRectMake(0, 0, 1, 13))
color.setFill()
rectanglePath.fill()

CGContextRestoreGState(context)


//// Rectangle 2 Drawing
CGContextSaveGState(context)
CGContextTranslateCTM(context, 11.19, 5.1)
CGContextRotateCTM(context, 45 * CGFloat(M_PI) / 180)

let rectangle2Path = UIBezierPath(rect: CGRectMake(0, 0, 1, 13))
color.setFill()
rectangle2Path.fill()

CGContextRestoreGState(context)

