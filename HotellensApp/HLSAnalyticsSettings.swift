//
//  HLSAnalyticsSettings.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import GoogleAnalytics_iOS_SDK


class HLSAnalyticsSettings:NSObject{
    
    
    class var setUpAnalytics : HLSAnalyticsSettings {
        struct Static {
            static let instance : HLSAnalyticsSettings = HLSAnalyticsSettings()
        }
        return Static.instance
    }
    
    override init() {
        // Optional: automatically send uncaught exceptions to Google Analytics.
        var gai = GAI.sharedInstance()
        gai.trackUncaughtExceptions = true
        // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
        gai.dispatchInterval = 10
        // Initialize tracker. Replace with your tracking ID.
        gai.trackerWithTrackingId("UA-56658902-1")
        
        gai.logger?.logLevel = GAILogLevel.None
        super.init()
        
    }
}