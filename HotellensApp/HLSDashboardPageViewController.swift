//
//  HLSDashboardPageViewController.swift
//  HotellensApp
//
//  Created by Johannes Karow on 28/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import UIKit
import GoogleAnalytics_iOS_SDK


class HLSDashboardPageViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var day:Day?
    
    override func viewDidLoad() {
        
        self.dataSource = self
        self.delegate = self
        
        //Getting today but cleaned from timezone information.
        var gmtCal = NSCalendar.currentCalendar()
        gmtCal.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        var date = NSNumber(double: gmtCal.startOfDayForDate(NSDate()).timeIntervalSince1970)
        self.day = Day.byID(date, pkName: "date") as? Day
        
        //If today is note in coredata we try to find another date
        if self.day == nil{
            if let nextDay = Day.getNextByDay(date){
                self.day = nextDay
            }else if let beforeDay = Day.getBeforeByDay(date){
                self.day = beforeDay
            }else{
                // Error no day in Database...
            }
        }
        
        
        /*let startingViewController = self.viewControllerForDay(self.day!)
        
        let viewControllers: NSArray = [startingViewController]
        self.setViewControllers(viewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)*/
        
    }
    
    
    func viewControllerForDay(day:Day) -> GAITrackedViewController{
        
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("dashboard") as! HLSDashboardViewController
        pageContentViewController.day = day
        return pageContentViewController
        
    }
}

// Implement the required protocol-function
extension HLSDashboardPageViewController: UIPageViewControllerDataSource{
        
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let dashBoardContentController = viewController as! HLSDashboardViewController
        
        if let currentDay = dashBoardContentController.day,
            let nextDay = currentDay.getNextDay(){
                return self.viewControllerForDay(nextDay)
        }else{
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let dashBoardContentController = viewController as! HLSDashboardViewController
        
        if let currentDay = dashBoardContentController.day,
            let beforeDay = currentDay.getBeforeDay(){
                return self.viewControllerForDay(beforeDay)
        }else{
            return nil
        }
    }
}