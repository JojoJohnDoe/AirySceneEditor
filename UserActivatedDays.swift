//
//  UserActivatedDays.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

class UserActivatedDays: NSManagedObject {
    
    @NSManaged var isoDay: NSNumber
    @NSManaged var isHoliday: NSNumber
    @NSManaged var activated: NSNumber

}
