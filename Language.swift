//
//  Language.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

class Language: NSManagedObject {

    @NSManaged var iso639code: String
    @NSManaged var name: String
    @NSManaged var pk: NSNumber
    @NSManaged var r_userInfo: NSSet

}
