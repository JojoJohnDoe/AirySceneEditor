//
//  HLSChartViewController.swift
//  HotellensApp
//
//  Created by Johannes Karow on 26/08/14.
//  Copyright (c) 2014 Hotellens. All rights reserved.
//

import UIKit
import GoogleAnalytics_iOS_SDK

class HLSChartViewController: GAITrackedViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Send hits to Google Analytics
        self.screenName = "Charts"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

