//
//  DayInfoForRoomType.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

enum Trend: Int32{
    case StrongDown, Down, Unchanged, Up, StrongUp
}

class DayInfoForRoomType: NSManagedObject {

    @NSManaged var occupancy_competitors: NSDecimalNumber
    @NSManaged var occupancy_region: NSDecimalNumber
    @NSManaged var occupancy_subscriber: NSDecimalNumber
    @NSManaged var price_max: NSDecimalNumber
    @NSManaged var price_min: NSDecimalNumber
    @NSManaged var price_subscriber: NSDecimalNumber
    @NSManaged var price_subscriber_flag: NSNumber
    @NSManaged var price_yielding: NSDecimalNumber
    @NSManaged var price_trend: Int32
    @NSManaged var created: NSNumber
    @NSManaged var day: Day
    @NSManaged var roomType: RoomType

    var trend: Trend{
        get {
            return Trend(rawValue: self.price_trend)!
        }
        set{
            self.price_trend = newValue.rawValue
        }
    }
}