//
//  Hotel.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

class Hotel: NSManagedObject {

    @NSManaged var activated: NSNumber
    @NSManaged var color: String
    @NSManaged var img_url: String
    @NSManaged var latitude: String
    @NSManaged var longitude: String
    @NSManaged var name: String
    @NSManaged var name_short: String
    @NSManaged var order: NSNumber
    @NSManaged var pk: NSNumber
    @NSManaged var rating: NSNumber
    @NSManaged var r_userInfo: NSSet

}
