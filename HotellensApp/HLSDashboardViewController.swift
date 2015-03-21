//
//  HLSDashboardViewController.swift
//  HotellensApp
//
//  Created by Johannes Karow on 26/08/14.
//  Copyright (c) 2014 Hotellens. All rights reserved.
//

import UIKit
import GoogleAnalytics_iOS_SDK


class HLSDashboardViewController: GAITrackedViewController,UITableViewDelegate, UITableViewDataSource {

    // TODO: Auf LowMemoryWarning-Notification hören und entsprechende Objekte löschen! (kommt über das NotificationCenter)
    
    // ACHTUNG soll das Laden von Daten und anzeigen der Tableview implementiert werden bitte hier nachschauen: http://www.raywenderlich.com/59255/afnetworking-2-0-tutorial
    // und natürlich im schon vorhandenen Xcode projekt
    
    // set the restorationIdentifier for the needed pageViewController
    //let restorationIdentifier = "dashboard"
    
    var cell1 : HLSDashboardCell1?
    var cell2 : HLSDashboardCell2?
    var cell3 : HLSDashboardChartView?
    var cell4 : HLSDashboardChartView?
    var cell5 : HLSDashboardChartViewTableViewCell?
    
    var pageIndex: Int?
    var day : Day?
    
    @IBOutlet weak var dateBar: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Load the CustomTableViewCell interface file into a UINib object and then tell the table view to use it for the customCell reuse identifier.
        let nib                                   = UINib(nibName: "HLSDashboardCell1", bundle: nil)
        let nib2                                  = UINib(nibName: "HLSDashboardCell2", bundle: nil)
        let nibHLSDashboardChartViewPortalRanking = UINib(nibName: "HLSDashboardChartView", bundle: nil)
        let nibHLSDashboardChartViewRankingTrend  = UINib(nibName: "HLSDashboardChartView", bundle: nil)

        // only for Testing
        let nibChartViewTableViewCell             = UINib(nibName: "HLSDashboardChartViewCell", bundle: nil)
        
        tableView.registerNib(nib, forCellReuseIdentifier: "HLSDashboardCell1")
        tableView.registerNib(nib2, forCellReuseIdentifier: "HLSDashboardCell2")
        tableView.registerNib(nibHLSDashboardChartViewPortalRanking, forCellReuseIdentifier: "HLSDashboardChartView")
        tableView.registerNib(nibHLSDashboardChartViewRankingTrend, forCellReuseIdentifier: "HLSDashboardChartView")
        
        // only for Testing
        tableView.registerNib(nibChartViewTableViewCell, forCellReuseIdentifier: "HLSDashboardChartViewTableViewCell")


        // Calculate RowHeight based on Content in xib (new in iOS8)
        tableView.estimatedRowHeight = 100.0  // sets the estimated row height of the cell, which is the height of the existing prototype cell
        tableView.rowHeight          = UITableViewAutomaticDimension

        
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        // Send hits to Google Analytics
        self.screenName              = "Dashboard"
        
        
        // Format Navigation bar with current Date
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle //Set time style
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle //Set date style
        dateFormatter.timeZone = NSTimeZone()
        
        dateBar.title = dateFormatter.stringFromDate(
            NSDate(timeIntervalSince1970: NSTimeInterval(self.day!.date)))
        
        
        println("Showing "+dateBar.title!)
        
    }
    
    /*override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        println("Memorywarning!")
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: return appropriate Cellcount after implementing the remaining cells.
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Switch xib based on indexpath and section
        switch (indexPath.row, indexPath.section) {
            case (0, 0):
                
                cell1  = self.tableView.dequeueReusableCellWithIdentifier("HLSDashboardCell1") as? HLSDashboardCell1
                
                //Debugcontent
                //cell1!.nameLabel.text        = self.restorationIdentifier
                
                cell1!.userInteractionEnabled = false
                return cell1!
            
            case (1, 0):
                
                cell2  = self.tableView.dequeueReusableCellWithIdentifier("HLSDashboardCell2") as? HLSDashboardCell2
                
                cell2!.userInteractionEnabled = false

                //Debugcontent
                cell2!.drawDailyRate()
                /*cell.setNeedsUpdateConstraints()
                cell.setNeedsLayout()
                cell.layoutIfNeeded()*/
                
                return cell2!
            case (2, 0):
                // TableviewCell: Portalranking
                
                cell3  = self.tableView.dequeueReusableCellWithIdentifier("HLSDashboardChartView") as? HLSDashboardChartView
                
                cell3!.userInteractionEnabled = false
                
                cell3!.nameLabel!.text = "Portalranking"
                //Debugcontent
                /*cell.setNeedsUpdateConstraints()
                cell.setNeedsLayout()
                cell.layoutIfNeeded()*/
                
                return cell3!
            case (3, 0):
                // TableviewCell: Bewertungstrend
                
                cell4  = self.tableView.dequeueReusableCellWithIdentifier("HLSDashboardChartView") as? HLSDashboardChartView
                
                //var textViewController : HLSDashboardChartViewTableViewController
                
                //textViewController
                //textViewController.tableView = cell4?.chartTableView
                
                cell4!.userInteractionEnabled = false
                
                cell4!.nameLabel!.text = "Bewertungstrend"
                //Debugcontent
                /*cell.setNeedsUpdateConstraints()
                cell.setNeedsLayout()
                cell.layoutIfNeeded()*/
                
                return cell4!
            
            /*case (4, 0):
                
                cell5  = self.tableView.dequeueReusableCellWithIdentifier("HLSDashboardChartViewTableViewCell") as? HLSDashboardChartViewTableViewCell
                
                cell5!.userInteractionEnabled = false
                cell5!.scoreLabel.text = "2.8"
                cell5!.competitorLabel.text = "Check24.de"
                //Debugcontent
                /*cell.setNeedsUpdateConstraints()
                cell.setNeedsLayout()
                cell.layoutIfNeeded()*/
                
                return cell5!*/
            default:
                // Return a fallback Cell. Maybe return a propper error Message instead? (TODO)
                var cell:HLSDashboardCell1 = self.tableView.dequeueReusableCellWithIdentifier("HLSDashboardCell1") as! HLSDashboardCell1
                println("Inappropriate input for indexpath!")
                return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("You selected cell #\(indexPath.row)!")
        //hallo = "hey was geht"
        tableView.reloadData()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        tableView.reloadData()
    }
}