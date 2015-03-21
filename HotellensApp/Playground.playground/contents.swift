// Playground - noun: a place where people can play

import Cocoa

var gmt = NSCalendar.currentCalendar()
gmt.timeZone = NSTimeZone(forSecondsFromGMT: 0)
let toDay = gmt.startOfDayForDate(NSDate())
toDay.timeIntervalSince1970


let dateFormatter = NSDateFormatter()
//To prevent displaying either date or time, set the desired style to NoStyle.
dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle //Set time style
dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle //Set date style
dateFormatter.timeZone = NSTimeZone()
let localDate = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: 0))
localDate
