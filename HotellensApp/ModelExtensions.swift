//
//  ModelExtensions.swift
//  HotellensApp
//
//  Created by Tom Jaster on 14/03/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
extension Day{
    class func getNextByDay(day:NSNumber)->Day?{
        let sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        let predicate = NSPredicate(format: "SELF.date > %@", day)
        var request = Day.createFetchRequest(predicate: predicate, sortDescriptors: sortDescriptors)
        let result = AERecord.defaultContext.executeFetchRequest(request, error: nil)
        return result?.first as? Day
        
    }
    class func getBeforeByDay(day:NSNumber)->Day?{
        let sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let predicate = NSPredicate(format: "SELF.date < %@", day)
        var request = Day.createFetchRequest(predicate: predicate, sortDescriptors: sortDescriptors)
        let result = AERecord.defaultContext.executeFetchRequest(request, error: nil)
        return result?.first as? Day
        
    }
    func getNextDay() -> Day?{
        return Day.getNextByDay(self.date)
    }
    
    func getBeforeDay() -> Day?{
        return Day.getBeforeByDay(self.date)
    }
}