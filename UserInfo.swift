//
//  UserInfo.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

class UserInfo: NSManagedObject {
    
    @NSManaged var pk: NSNumber
    @NSManaged var currency_decimal: String
    @NSManaged var currency_symbol: String
    @NSManaged var currency_thousands: String
    @NSManaged var currency_left: NSNumber
    @NSManaged var hotline_freecall: String
    @NSManaged var hotline_phone: String
    @NSManaged var user_city: String
    @NSManaged var user_country_iso: String
    @NSManaged var user_country_name: String
    @NSManaged var user_state: String
    @NSManaged var user_timestamp: String
    @NSManaged var user_timezone: String
    @NSManaged var user_zip: String
    @NSManaged var included_rate: NSNumber
    @NSManaged var included_rateType: NSNumber
    @NSManaged var included_breakfast: NSNumber
    @NSManaged var currency: Currency
    @NSManaged var hotel: Hotel
    @NSManaged var language: Language
    @NSManaged var roomType: RoomType
    @NSManaged var length_of_stay: LengthOfStay

}
