//
//  ARDeviceSelector.swift
//  AirySceneEditor
//
//  Created by Johannes Karow on 21/03/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//


import UIKit
import GoogleAnalytics_iOS_SDK

class ARDeviceSelector: UITableViewController, UIGestureRecognizerDelegate {
    
    var itemsArray : [String]
    var rootPageViewController : ARPageViewController?
    
    required init(coder aDecoder: NSCoder) {
        itemsArray = [String]()
        
        let item1 = "Bananas"
        let item2 = "Oranges"
        let item3 = "Kale"
        let item4 = "Milk"
        let item5 = "Yogurt"
        let item6 = "Crackers"
        let item7 = "Cheese"
        let item8 = "Carrots"
        let item9 = "Ice Cream"
        let item10 = "Olive Oil"
        
        itemsArray.append(item1)
        itemsArray.append(item2)
        itemsArray.append(item3)
        itemsArray.append(item4)
        itemsArray.append(item5)
        itemsArray.append(item6)
        itemsArray.append(item7)
        itemsArray.append(item8)
        itemsArray.append(item9)
        itemsArray.append(item10)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let longpress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        longpress.delegate = self
        
        tableView.addGestureRecognizer(longpress)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = itemsArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    // MARK: - Draggable Cell
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        
        let state = longPress.state
        
        var locationInView = longPress.locationInView(self.rootPageViewController!.view)
        
        var indexPath = tableView.indexPathForRowAtPoint(locationInView)
        
        struct My {
            
            static var cellSnapshot : UIView? = nil
            
        }
        struct Path {
            
            static var initialIndexPath : NSIndexPath? = nil
            
        }
        
        switch state {
            case UIGestureRecognizerState.Began:
                if indexPath != nil {
                    Path.initialIndexPath = indexPath
                    let cell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
                    My.cellSnapshot  = snapshopOfCell(cell)
                    var center = cell.center
                    
                    My.cellSnapshot!.center = center
                    
                    My.cellSnapshot!.alpha = 0.0
                    
                    tableView.addSubview(My.cellSnapshot!)
                    
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        center.y = locationInView.y
                        
                        My.cellSnapshot!.center = center
                        
                        My.cellSnapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                        
                        My.cellSnapshot!.alpha = 0.98
                        
                        cell.alpha = 0.0
                        
                        }, completion: { (finished) -> Void in
                            
                            if finished {
                                
                                cell.hidden = true
                                
                            }
                            
                    })
                    
                }
                //rootPageViewController?.changeToRighteee()
            
            case UIGestureRecognizerState.Changed:
                var center = My.cellSnapshot!.center
                let cgfloetvar = CGFloat(50)
                center.y = locationInView.y
                center.x = locationInView.x
                My.cellSnapshot!.center = center
                if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                    swap(&itemsArray[indexPath!.row], &itemsArray[Path.initialIndexPath!.row])
                    tableView.moveRowAtIndexPath(Path.initialIndexPath!, toIndexPath: indexPath!)
                    Path.initialIndexPath = indexPath
                }
                
            
            default:
                let cell = tableView.cellForRowAtIndexPath(Path.initialIndexPath!) as UITableViewCell!
                cell.hidden = false
                cell.alpha = 0.0
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    My.cellSnapshot!.center = cell.center
                    My.cellSnapshot!.transform = CGAffineTransformIdentity
                    My.cellSnapshot!.alpha = 0.0
                    cell.alpha = 1.0
                    }, completion: { (finished) -> Void in
                        if finished {
                            Path.initialIndexPath = nil
                            My.cellSnapshot!.removeFromSuperview()
                            My.cellSnapshot = nil
                        }
                    }
                )
        }
    }
    
        
    

    func snapshopOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }


}