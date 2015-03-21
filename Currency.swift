//
//  Currency.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

class Currency: NSManagedObject {

    @NSManaged var ios_identifier: String
    @NSManaged var name_short: String
    @NSManaged var pk: NSNumber
    @NSManaged var r_userInfo: NSSet

}
