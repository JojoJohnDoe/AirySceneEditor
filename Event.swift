//
//  Event.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

class Event: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var pk: NSNumber

}
