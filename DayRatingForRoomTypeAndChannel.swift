//
//  DayRatingForRoomTypeAndChannel.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

class DayRatingForRoomTypeAndChannel: NSManagedObject {

    @NSManaged var value: NSNumber
    @NSManaged var trend: NSNumber
    @NSManaged var channel: Channel
    @NSManaged var day: Day
    @NSManaged var roomType: RoomType
    @NSManaged var ranking_value: NSNumber
    @NSManaged var ranking_trend: NSNumber

}
