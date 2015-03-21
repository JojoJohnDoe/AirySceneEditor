//
//  Day.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

class Day: NSManagedObject {

    @NSManaged var date: NSNumber
    @NSManaged var info: NSSet
    @NSManaged var rating: NSSet

}
