//
//  UserDefaultDefaults.swift
//  HotellensApp
//
//  Created by Tom Jaster on 31/01/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class UserDefaultDefaults{
    init(){
        // ?= means set only if nil
        // is provided by SwiftyUserDefaults
        Defaults["isLoggedIn"] ?= false
    }
}