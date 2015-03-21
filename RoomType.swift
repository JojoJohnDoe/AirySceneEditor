//
//  RoomType.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

class RoomType: NSManagedObject {

    @NSManaged var adult_count: NSNumber
    @NSManaged var name: String
    @NSManaged var name_short: String
    @NSManaged var pk: NSNumber
    @NSManaged var r_dayInfoForRoomType: NSSet
    @NSManaged var r_dayRatingForRoomTypeAndChannel: NSSet
    @NSManaged var r_userInfo: NSSet

}
