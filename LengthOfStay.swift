//
//  LengthOfStay.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

class LengthOfStay: NSManagedObject {

    @NSManaged var pk: NSNumber
    @NSManaged var text: String
    @NSManaged var r_User: NSSet

}
