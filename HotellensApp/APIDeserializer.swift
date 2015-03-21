//
//  APIDeserializer.swift
//  HotellensApp
//
//  Created by Tom Jaster on 10/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation
import CoreData

class DHelper{
    class func getPK(pk:AnyObject)->NSNumber{
        return (pk as! String).toInt()!
    }
    class func toInt(intStr:AnyObject)->NSNumber{
        return (intStr as! String).toInt()!
    }
    class func toDouble(intStr:AnyObject)->NSNumber{
        var  f = NSNumberFormatter()
        f.numberStyle = NSNumberFormatterStyle.DecimalStyle
        f.decimalSeparator = "."
        return f.numberFromString(intStr as! String)!
    }
}



class APIDeserializer{
    
    //MARK:dfdf
    func deserializeDashBoard(xml:AEXMLDocument){
        
        //TODO: Align/Fomat code
        //TODO: Import Events
        
        //for now delete everything first for a clean empty state :]
        //AERecord.truncateAllData()
        
        //First create everything with no relationships
        //Setting setup
        println("Importing LengthOfStay")
        LengthOfStay.deSerialize(xml)
        
        println("Importing Currency")
        Currency.deSerialize(xml)
        
        println("Importing Language")
        Language.deSerialize(xml)
        
        println("Importing RoomType")
        RoomType.deSerialize(xml)
        
        println("Importing EventConfig")
        EventConfig.deSerialize(xml)
        
        println("Importing UserActivatedDays")
        UserActivatedDays.deSerialize(xml)
        
        //Data Setup
        println("Importing Channel")
        Channel.deSerialize(xml)
        
        println("Importing Hotel")
        Hotel.deSerialize(xml)
        
        println("Importing Day")
        Day.deSerialize(xml)
        
        //Create everything with relationships in a sane dependancy order
        println("Importing UserInfo")
        UserInfo.deSerialize(xml)
        
        println("Importing DayRatingForRoomTypeAndChannel")
        DayRatingForRoomTypeAndChannel.deSerialize(xml)
        
        println("Importing DayInfoForRoomType")
        DayInfoForRoomType.deSerialize(xml)
        
        /*
        //unknown for now
        Event
        */
        
        AERecord.saveContext()
        
    }
}


extension LengthOfStay{
    class func findElementsinXML(xml:AEXMLDocument)->[AEXMLElement]{
        return xml.root["Settings"]["LengthOfStay"]["LengthOfStay"].all!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[NSString:AnyObject]{
        return [
            "text":el.stringValue,
            "pk":el.attributes["ID"]! => DHelper.getPK
        ]
    }
    
    class func deSerialize(xml:AEXMLDocument){
        xml => findElementsinXML => createInfoFromElements => self.updateOrCreate
    }
}

extension Currency{
    class func findElementsinXML(xml:AEXMLDocument)->[AEXMLElement]{
        return xml.root["Settings"]["Currency"]["List"]["Currency"].all!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[NSString:AnyObject]{
        return [
            "pk":el.attributes["ID"]! => DHelper.getPK,
            "name_short":el.stringValue
        ]
    }
    
    class func deSerialize(xml:AEXMLDocument){
        xml => findElementsinXML => createInfoFromElements => self.updateOrCreate
    }
}

extension Language{
    class func findElementsinXML(xml:AEXMLDocument)->[AEXMLElement]{
        return xml.root["Settings"]["Language"]["Language"].all!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[NSString:AnyObject]{
        return [
            "pk":el.attributes["ID"]! => DHelper.getPK,
            "iso639code":el.attributes["iso639code"]!
        ]
    }
    
    class func deSerialize(xml:AEXMLDocument){
        xml => findElementsinXML => createInfoFromElements => self.updateOrCreate
    }
}
extension RoomType{
    class func findElementsinXML(xml:AEXMLDocument)->[AEXMLElement]{
        return xml.root["Settings"]["Adults"]["Adults"].all!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[NSString:AnyObject]{
        return [
            "pk":el.attributes["ID"]! => DHelper.getPK,
            "adult_count":el.intValue,
            "name":el.attributes["Name"]!,
            "name_short":el.attributes["Abbreviated"]!
        ]
    }
    
    class func deSerialize(xml:AEXMLDocument){
        xml => findElementsinXML => createInfoFromElements => self.updateOrCreate
    }
}
extension EventConfig{
    class func findElementsinXML(xml:AEXMLDocument)->[AEXMLElement]{
        return xml.root["Settings"]["Events"]["EventID"].all!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[NSString:AnyObject]{
        return [
            "pk":el.attributes["ID"]! => DHelper.getPK,
            "color":el.attributes["ColorHex"]!
        ]
    }
    
    class func deSerialize(xml:AEXMLDocument){
        xml => findElementsinXML => createInfoFromElements => self.updateOrCreate
    }
}
extension UserActivatedDays{
    class func findElementsinXML(xml:AEXMLDocument)->[AEXMLElement]{
        return xml.root["Settings"]["Days"]["Day"].all!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[NSString:AnyObject]{
        return [
            "isoDay":el.attributes["ID"]! => DHelper.getPK,
            "isHoliday":el.attributes["IsHoliday"]! => DHelper.toInt,
            "activated":el.attributes["SubscriberActivatedBool"]! => DHelper.toInt
        ]
    }
    
    class func deSerialize(xml:AEXMLDocument){
        let uniqueKeys = "isoDay"
        let elements = xml => findElementsinXML => createInfoFromElements
        for element in elements{
            self.updateOrCreateByPK(element, pkName: uniqueKeys)
        }
    }
}

extension Channel{
    class func findElementsinXML(xml:AEXMLDocument)->[AEXMLElement]{
        return xml.root["Settings"]["Channels"]["ChannelID"].all!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[NSString:AnyObject]{
        return [
            "pk":el.attributes["ID"]! => DHelper.getPK,
            "name":el.stringValue,
            "name_short":el.attributes["Abbreviated"]!,
            "activated":el.attributes["SubscriberActivatedBool"]! => DHelper.toInt
        ]
    }
    
    class func deSerialize(xml:AEXMLDocument){
        xml => findElementsinXML => createInfoFromElements => self.updateOrCreate
    }
}
extension Hotel{
    class func findElementsinXML(xml:AEXMLDocument)->[AEXMLElement]{
        return xml.root["Settings"]["SubscriberAndCompetitors"]["HotelDetails"].all!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[NSString:AnyObject]{
        var attrs = [
            "pk":el["Hotel"].attributes["ID"]! => DHelper.getPK,
            "name":el["HotelName"].attributes["Value"]!,
            "name_short":el["HotelNameAbbreviated"].attributes["Value"]!,
            "latitude":el["HotelGeoLatitude"].attributes["Value"]!,// => DHelper.toDouble,
            "longitude":el["HotelGeoLongitude"].attributes["Value"]!,// => DHelper.toDouble,
            "order":el["HotelID"].attributes["AscendingOrder"]! => DHelper.toInt,
            "activated":el["HotelID"].attributes["SubscriberActivatedBool"]! => DHelper.toInt,
            "color":el["HotelID"].attributes["ColorHex"]!
        ]
        if let value = el.attributes["Abbreviated"] as! String? {
            attrs.updateValue(value, forKey: "img_url")
        }
        if let value = (el["HotelRating"].attributes["Value"] as! String?)?.toInt() {
            attrs.updateValue(value, forKey: "rating")
        }
        
        return attrs
    }
    
    class func deSerialize(xml:AEXMLDocument){
        xml => findElementsinXML => createInfoFromElements => self.updateOrCreate
    }
}
extension Day{
    class func findElementsinXML(xml:AEXMLDocument)->[AEXMLElement]{
        return xml.root["DailyData"]["UnixtimeUTC"].all!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[NSString:AnyObject]{
        return [
            "date":el.attributes["Value"]! => DHelper.getPK
        ]
    }
    
    class func deSerialize(xml:AEXMLDocument){
        let uniqueKeys = "date"
        let elements = xml => findElementsinXML => createInfoFromElements
        for element in elements{
            self.updateOrCreateByPK(element, pkName: uniqueKeys)
        }
    }
}
extension UserInfo{
    class func findElementsinXML(xml:AEXMLDocument)->AEXMLElement{
        return xml.root["Settings"].first!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[NSString:AnyObject]{
        let subsData = el["SubscriberData"]
        let currency = el["Currency"]
        let hotline = el["Support"]["Hotline"]
        
        var objId = subsData["CurrencyID"].attributes["Value"]! => DHelper.toInt
        var currencyObj = Currency.byID(objId)
        
        objId = subsData["Hotel"].attributes["ID"]! => DHelper.toInt
        var hotel = Hotel.byID(objId)
        objId = subsData["LanguageID"].attributes["Value"]! => DHelper.toInt
        var language = Language.byID(objId)
        objId = subsData["AdultsID"].attributes["Value"]! => DHelper.toInt
        var roomtype = RoomType.byID(objId)
        objId = subsData["LengthOfStayID"].attributes["Value"]! => DHelper.toInt
        var lengthofstay = LengthOfStay.byID(objId)
        
        var attrs = [
            //UserInfo should be a singleton so we set pk to 1
            "pk":1,
            "currency_decimal":currency["DecimalHTMLEntity"].stringValue,
            "currency_symbol":currency["SymbolHTMLEntity"].stringValue,
            "currency_thousands":currency["ThousandsSeparatorHTMLEntity"].stringValue,
            "currency_left":currency["SymbolPlacementLeftRight"].boolValue,
            "hotline_freecall":hotline.attributes["Freecall"]!,
            "hotline_phone":hotline.attributes["Phone"]!,
            "user_city":subsData["RegionCity"].attributes["Value"]!,
            "user_country_iso":subsData["RegionCountry"].attributes["ISO"]!,
            "user_country_name":subsData["RegionCountry"].attributes["Name"]!,
            "user_timestamp":subsData["Timestamp"].attributes["Value"]!,
            "user_timezone":subsData["Timezone"].attributes["Value"]!,
            "user_zip":subsData["RegionZip"].attributes["Value"]!,
            "included_rate":subsData["RateID"].attributes["Value"]! => DHelper.toInt,
            "included_rateType":subsData["RateTypeID"].attributes["Value"]! => DHelper.toInt,
            "included_breakfast":subsData["BreakfastIncludedID"].attributes["Value"]! => DHelper.toInt,
            "currency":currencyObj!,
            "hotel":hotel!,
            "language":language!,
            "roomType":roomtype!,
            "length_of_stay":lengthofstay!
            
        ]
        if let value = subsData["RegionState"].attributes["Value"] as! String? {
            attrs.updateValue(value, forKey: "user_state")
        }
        return attrs
    }
    
    class func deSerialize(xml:AEXMLDocument){
        xml => findElementsinXML => createInfoFromElements => self.updateOrCreate
    }
}


extension DayRatingForRoomTypeAndChannel{
    class func findElementsinXML(xml:AEXMLDocument)->[AEXMLElement]{
        return xml.root["DailyData"]["UnixtimeUTC"].all!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[[NSString:AnyObject]]{
        var objID = el.attributes["Value"]! => DHelper.getPK
        let dayObj = Day.byID(objID,pkName:"date")
        
        var ret:[[NSString:AnyObject]] = []
        for roomInfo in el["Adults"].all!{
            objID = roomInfo.attributes["ID"]! => DHelper.toInt
            let roomTypeObj = RoomType.byID(objID)
            
            for rating in roomInfo["Rating"].all!{
                objID = rating.attributes["ChannelID"]! => DHelper.toInt
                let channelObj = Channel.byID(objID)
                
                var retItem = [
                    "day":dayObj!,
                    "roomType":roomTypeObj!,
                    "channel":channelObj!,
                    "trend":rating.attributes["Trend"]! => DHelper.toInt,
                    "value":rating.attributes["Value"]! => DHelper.toInt,
                ]
                if let ranking =
                    roomInfo["Ranking"]["RankingPosition"].allWithAttributes(
                        ["ChannelID":objID.stringValue as NSString])?.first{
                            
                            retItem.updateValue(ranking.attributes["Trend"]! => DHelper.toInt, forKey: "Trend")
                            retItem.updateValue(ranking.attributes["Value"]! => DHelper.toInt, forKey: "Value")
                }
                ret.append(retItem)
            }
        }
        return ret
    }
    
    class func deSerialize(xml:AEXMLDocument){
        let uniqueKeys = ["day", "roomType", "channel"]
        let elements = xml => findElementsinXML => createInfoFromElements
        for elementList in elements{
            for element in elementList{
                self.updateOrCreateByMultiPK(element, pkNames: uniqueKeys)
            }
        }
    }
}


extension DayInfoForRoomType{
    class func findElementsinXML(xml:AEXMLDocument)->[AEXMLElement]{
        return xml.root["DailyData"]["UnixtimeUTC"].all!
    }
    
    class func createInfoFromElements(el:AEXMLElement)->[[NSString:AnyObject]]{
        var objID = el.attributes["Value"]! => DHelper.getPK
        let dayObj = Day.byID(objID,pkName:"date")
        
        var ret:[[NSString:AnyObject]] = []
        for roomInfo in el["Adults"].all!{
            objID = roomInfo.attributes["ID"]! => DHelper.toInt
            let roomTypeObj = RoomType.byID(objID)
            
            
            var retItem = [
                "day":dayObj!,
                "roomType":roomTypeObj!,
                "occupancy_competitors":roomInfo["OccupancyCompetitors"].attributes["Value"]! => DHelper.toDouble,
                "occupancy_region":roomInfo["OccupancyRegion"].attributes["Value"]! => DHelper.toDouble,
                "occupancy_subscriber":roomInfo["OccupancySubscriber"].attributes["Value"]! => DHelper.toDouble,
                "price_min":roomInfo["MinPrice"].attributes["Value"]! => DHelper.toDouble,
                "price_max":roomInfo["MaxPrice"].attributes["Value"]! => DHelper.toDouble,
                "price_subscriber":roomInfo["SubscriberPrice"].attributes["Value"]! => DHelper.toDouble,
                "price_subscriber_flag":roomInfo["SubscriberPrice"].attributes["Flag"]! => DHelper.toInt,
                "price_yielding":roomInfo["PriceYielding"].attributes["Value"]! => DHelper.toDouble,
                "price_trend":roomInfo["PriceTrend"].attributes["ID"]! => DHelper.toInt,
                "created":roomInfo.attributes["PriceDataFromUnixtimeUTC"]! => DHelper.toInt
            ]
            ret.append(retItem)
        }
        return ret
    }
    
    class func deSerialize(xml:AEXMLDocument){
        let uniqueKeys = ["day", "roomType"]
        let elements = xml => findElementsinXML => createInfoFromElements
        for elementList in elements{
            for element in elementList{
                self.updateOrCreateByMultiPK(element, pkNames: uniqueKeys)
            }
        }
    }
}