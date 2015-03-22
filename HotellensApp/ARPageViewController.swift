//
//  ARPageViewController.swift
//  AirySceneEditor
//
//  Created by Johannes Karow on 22/03/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation

import UIKit
import GoogleAnalytics_iOS_SDK


class ARPageViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    var leftVC : ARDeviceSelector?
    var rightVC : ARTriggerEditor?
    
    var index = 0
    //var identifiers: NSArray = ["dashboard1", "dashboard2", "dashboard3","dashboard3","dashboard3","dashboard3"]
    let numberOfScrollableViews = 2
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        
        self.dataSource = self
        self.delegate = self
        
        leftVC = self.storyboard?.instantiateViewControllerWithIdentifier("deviceSelector") as? ARDeviceSelector
        leftVC?.rootPageViewController = self
        rightVC = self.storyboard?.instantiateViewControllerWithIdentifier("triggerEditor") as? ARTriggerEditor
        rightVC?.rootPageViewController = self
        let viewControllers: NSArray = [leftVC!]
        self.setViewControllers(viewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
   
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return numberOfScrollableViews
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func changeToRighteee(){
        self.setViewControllers([rightVC!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
    
}

// Implement the required protocol-function
extension ARPageViewController: UIPageViewControllerDataSource{
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if (viewController is ARDeviceSelector){
            return rightVC
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if (viewController is ARTriggerEditor){
            return leftVC
        } else {
            return nil
        }
    }
    
}