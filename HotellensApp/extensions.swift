//
//  extensions.swift
//  HotellensApp
//
//  Created by Tom Jaster on 11/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject{
    class func updateOrCreate(attrs:[NSString:AnyObject]){
        let uniqueKeys = ["pk"]
        let pkName:String=uniqueKeys.first!
        let pk: NSNumber = attrs[pkName] as! Int
        var obj = self.firstOrCreateWithAttribute(pkName, value: pk)
        for (key,value) in attrs{
            if key == pkName{continue}
            
            obj.setValue(value, forKey: key as! String)
        }
    }
    class func updateOrCreateByPK(attrs:[NSString:AnyObject],pkName:String="pk"){
        let pk: NSNumber = attrs[pkName] as! Int
        var obj = self.firstOrCreateWithAttribute(pkName, value: pk)
        for (key,value) in attrs{
            if key == pkName{continue}
            
            obj.setValue(value, forKey: key as! String)
        }
    }
    
    class func updateOrCreateByMultiPK(attrs:[NSString:AnyObject], pkNames:[String]){
        var predicates:[NSPredicate] = []
        for pk in pkNames{
            predicates.append(
                NSPredicate(format: "%K == %@", pk, (attrs[pk] as! NSManagedObject))
            )
        }
        var sumPredicate = NSCompoundPredicate.andPredicateWithSubpredicates(predicates)
        
        if let result = self.firstWithPredicate(sumPredicate) {
            for (key,value) in attrs{
                for pk in pkNames {if pk == key {continue} }
                result.setValue(value, forKey: key as! String)
            }
        } else{
            var obj = self.createWithAttributes(attrs)
        }
        
    }
    class func byID(value:NSNumber, pkName:String="pk")->NSManagedObject? {
        return self.firstWithAttribute(pkName, value: value)
    }
}