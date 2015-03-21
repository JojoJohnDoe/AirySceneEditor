//
//  HLSDashboardChartView.swift
//  HotellensApp
//
//  Created by Johannes Karow on 14/03/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//
import Foundation
import UIKit

class HLSDashboardChartView: UITableViewCell
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chartTableView: HLSDashboardChartViewTableView!
    
    var tableViewController : HLSDashboardChartViewTableViewController?

    
    override func awakeFromNib()
    {
    //Changes done directly here, we have an object
        //tableViewController = HLSDashboardChartViewTableViewController(style: UITableViewStyle.Plain)
        tableViewController = HLSDashboardChartViewTableViewController(nibName: "HLSDashboardChartViewTableView", bundle: nil)
        
        
        tableViewController!.tableView = chartTableView
        

    }
    
    required init(coder aDecoder: NSCoder) {
        //tableViewController!.init()
        super.init(coder: aDecoder)
    }
    
}

//MARK: ChartViewTableViewController
class HLSDashboardChartViewTableViewController: UITableViewController, UITableViewDelegate {
    
    // TODO: Auf LowMemoryWarning-Notification hören und entsprechende Objekte löschen! (kommt über das NotificationCenter)
    
    // ACHTUNG soll das Laden von Daten und anzeigen der Tableview implementiert werden bitte hier nachschauen: http://www.raywenderlich.com/59255/afnetworking-2-0-tutorial
    // und natürlich im schon vorhandenen Xcode projekt
    
    
    
    
    // var events: Dictionary<String, [String]> = ["0": ["Monroe Family", "La Cañada", "8:30"]]
    
    var cell : HLSDashboardChartViewTableViewCell?
    
  


    
    override func viewDidAppear(animated: Bool) {

    }
    
    override func viewWillAppear(animated: Bool) {
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        let nibChartViewTableViewCell             = UINib(nibName: "HLSDashboardChartViewCell", bundle: nil)
        tableView.registerNib(nibChartViewTableViewCell, forCellReuseIdentifier: "HLSDashboardChartViewTableViewCell")
        // tableView.registerClass(HLSDashboardChartViewTableViewCell.self, forCellReuseIdentifier: "HLSDashboardChartViewTableViewCell")
        
        // Calculate RowHeight based on Content in xib (new in iOS8)
        tableView.estimatedRowHeight = 20.0  // sets the estimated row height of the cell, which is the height of the existing prototype cell
        tableView.rowHeight          = UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    /*override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }*/
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return events.count
        return 4
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 31
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Switch xib based on indexpath and section
        switch (indexPath.row, indexPath.section) {
            case (0, 0):
                
                cell  = tableView.dequeueReusableCellWithIdentifier("HLSDashboardChartViewTableViewCell") as? HLSDashboardChartViewTableViewCell
                
                //cell!.userInteractionEnabled = false
                cell!.scoreLabel.text = "2.8"
                cell!.competitorLabel.text = "Check24.de"
                //Debugcontent
                /*cell.setNeedsUpdateConstraints()
                cell.setNeedsLayout()
                cell.layoutIfNeeded()*/
                
                return cell!
            case (1, 0):
                
                cell  = tableView.dequeueReusableCellWithIdentifier("HLSDashboardChartViewTableViewCell") as? HLSDashboardChartViewTableViewCell
                
                //cell!.userInteractionEnabled = false
                cell!.scoreLabel.text = "6.8"
                cell!.competitorLabel.text = "Trivago"
                //Debugcontent
                /*cell.setNeedsUpdateConstraints()
                cell.setNeedsLayout()
                cell.layoutIfNeeded()*/
                
                return cell!
            case (2, 0):
                
                cell  = tableView.dequeueReusableCellWithIdentifier("HLSDashboardChartViewTableViewCell") as? HLSDashboardChartViewTableViewCell
                
                //cell!.userInteractionEnabled = false
                cell!.scoreLabel.text = "4.8"
                cell!.competitorLabel.text = "Hotelscombined.de"
                //Debugcontent
                /*cell.setNeedsUpdateConstraints()
                cell.setNeedsLayout()
                cell.layoutIfNeeded()*/
                
                return cell!
            
            case (3, 0):
                
                cell  = tableView.dequeueReusableCellWithIdentifier("HLSDashboardChartViewTableViewCell") as? HLSDashboardChartViewTableViewCell
                let colorRed   = UIColor(red: 0.878, green: 0.337, blue: 0.345, alpha: 1.000)
                
                //cell!.userInteractionEnabled = false
                cell!.scoreLabel.text = "72.8"
                cell!.competitorLabel.text = "Tankstelle"
                //cell!.trendArrow.colorGreen = colorRed
                //Debugcontent
                /*cell.setNeedsUpdateConstraints()
                cell.setNeedsLayout()
                cell.layoutIfNeeded()*/
                
                return cell!
            
            default:
                // Return a fallback Cell. Maybe return a propper error Message instead? (TODO)
                cell  = tableView.dequeueReusableCellWithIdentifier("HLSDashboardChartViewTableViewCell") as? HLSDashboardChartViewTableViewCell
                
                //cell!.userInteractionEnabled = false
                cell!.scoreLabel.text = "2.8"
                cell!.competitorLabel.text = "Errorcell!"
                //Debugcontent
                /*cell.setNeedsUpdateConstraints()
                cell.setNeedsLayout()
                cell.layoutIfNeeded()*/
                
                return cell!
        }
    }
    
}

//MARK: ChartViewTableView
class HLSDashboardChartViewTableView: UITableView {
    
}


//MARK: ChartViewTableViewCell
class HLSDashboardChartViewTableViewCell: UITableViewCell
{
    @IBOutlet weak var trendArrow: TrendArrow!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var competitorLabel: UILabel!
    
    
}

//MARK: TrendArrow
class TrendArrow:UIView
{
    //let rotation : float_t

    //// Color Declarations
    var colorGreen = UIColor(red: 0.545, green: 0.843, blue: 0.216, alpha: 1.000)
    let colorRed   = UIColor(red: 0.878, green: 0.337, blue: 0.345, alpha: 1.000)
    
    override func drawRect(rect: CGRect) {
        /*// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        // Color Declarations
        let color = UIColor(red: 0.334, green: 0.869, blue: 0.159, alpha: 1.000)
        
        // Rectangle Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 10, 6.81)
        CGContextRotateCTM(context, -45 * CGFloat(M_PI) / 180)
        CGContextScaleCTM(context, 2.8, 1)
        
        let rectanglePath = UIBezierPath(rect: CGRectMake(0, 0, 1, 14.28))
        color.setFill()
        rectanglePath.fill()
        
        CGContextRestoreGState(context)
        
        
        //// Rectangle 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 11.19, 5.1)
        CGContextRotateCTM(context, 45 * CGFloat(M_PI) / 180)
        CGContextScaleCTM(context, 2.8, 1)
        
        let rectangle2Path = UIBezierPath(rect: CGRectMake(0, 0, 1, 14.21))
        color.setFill()
        rectangle2Path.fill()
        
        CGContextRestoreGState(context) */
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        
        //// Rectangle 3 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 8.73, 6.27)
        CGContextRotateCTM(context, 47 * CGFloat(M_PI) / 180)
        
        let rectangle3Path = UIBezierPath(rect: CGRectMake(0, 0, 11, 1.56))
        colorGreen.setFill()
        rectangle3Path.fill()
        
        CGContextRestoreGState(context)
        
        
        //// Rectangle Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 1.91, 6.27)
        CGContextRotateCTM(context, -47 * CGFloat(M_PI) / 180)
        
        let rectanglePath = UIBezierPath(rect: CGRectMake(-6.66, 4.65, 11, 1.56))
        colorGreen.setFill()
        rectanglePath.fill()
        
        CGContextRestoreGState(context)

    }
}