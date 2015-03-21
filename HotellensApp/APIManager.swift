//
//  RKSetup.swift
//  HotellensApp
//
//  Created by Tom Jaster on 29/01/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//


import Foundation
import SwiftyJSON
import Alamofire
import SwiftyUserDefaults

class APIManager{
    
    class var sharedInstance : APIManager {
        struct Static {
            static let instance : APIManager = APIManager()
        }
        return Static.instance
    }
    
    // Holds content from the plist file
    struct APIParams {
        let base_url : String
        let user_agent: String
        let auth_user: String
        let auth_passwd: String
        let params: JSON
    }
    let defaults: APIParams
    
    struct LoginState{
        var isLoggedIn = false
        var subriberHash:String?
        var user:String?
        var password:String?
    }
    var _loginState:LoginState?
    var loginState:LoginState {
        get {
            if _loginState == nil {
                self._loginState = LoginState(
                    isLoggedIn: Defaults["isLoggedIn"].bool!,
                    subriberHash: Defaults["subscriberHash"].string,
                    user: Defaults["user"].string,
                    password: Defaults["password"].string
                )
            }
            return _loginState!
        }
        set(newState) {
            _loginState = newState
            Defaults["isLoggedIn"] = newState.isLoggedIn
            Defaults["subriberHash"] = newState.subriberHash
            Defaults["user"] = newState.user
            Defaults["password"] = newState.password
        }
    }
    
    // Loads the api_config plist and sets our default request parameters
    init(){
        
        //Basic configuration
        let path = NSBundle.mainBundle().pathForResource("api_config", ofType: "plist")!
        var dict = JSON(NSDictionary(contentsOfFile: path)!)
        self.defaults = APIParams(
            base_url: dict["base_url"].stringValue,
            user_agent: dict["user_agent"].stringValue,
            auth_user: dict["auth_user"].stringValue,
            auth_passwd: dict["auth_passwd"].stringValue,
            params: dict["default_params"]
        )
        
    }
    
    
    //Basic Request function, every API Request should be a wrapper of this
    func request(
            parameters:JSON,
            responseHandler:(result:AEXMLDocument?,error:NSError?)->Void={$0;$1;}
        )   ->Void{
        
        // mix api endpoint specific parameters with our defaults
        var mergedParameters = self.defaults.params
        for (key:String , subJson: JSON) in parameters{
            mergedParameters[key] = subJson
        }
            
        var req = Alamofire.request(
            Alamofire.Method.POST,
            self.defaults.base_url,
            parameters: mergedParameters.dictionaryObject,
            encoding: ParameterEncoding.URL)
        .authenticate(user: self.defaults.auth_user, password: self.defaults.auth_passwd)
        //debugPrintln(req)
            req.responseString(encoding:NSUTF8StringEncoding){
            (request:NSURLRequest, response:NSHTTPURLResponse?,
                result:String?, error:NSError?)->Void in
            
            //Network level error or something like that
            if (error == nil) {
                // Parse XML
                var parseError:NSError?
                
                if let xml = AEXMLDocument(
                        xmlData: result!.dataUsingEncoding(NSUTF8StringEncoding)!,
                        error:&parseError){
                    // Check if XML contains an IsError True
                    if let responseCode = xml.root["Arguments"]["ResponseCode"].first
                         where responseCode["IsError"].boolValue {
                        // Return that our XML has a True IsError Field
                        let errorCode = responseCode["ResponseCode"].intValue
                        let xmlError = NSError(domain: "XMLResponseCode", code: errorCode, userInfo: nil)
                        responseHandler(result: xml,error: xmlError)
                    } else{
                        // Return with everything is OK and the XML
                        responseHandler(result: xml,error: nil)
                    }
                } else {
                    // Return with XML Parsing error
                    println("description: \(parseError?.localizedDescription)\ninfo: \(parseError?.userInfo)\nxmlStr: \(result!)")
                    responseHandler(result: nil,error: parseError)
                }
                
            } else {
                // return with HTTP/Network Error
                responseHandler(result: nil,error: error)
            }
        }
    
    }
    
    // Logs a user in and saves the credentials on successfull authface
    func login(user:String,password:String,
            loginHandler:(result:AEXMLDocument?,info:JSON?,error:NSError?)->Void
        )->Void{
        
        self.request(JSON([ "user":user,
                            "password":password,
                            "service":"LoginAuth"]))
            {(result:AEXMLDocument?,error:NSError?)->Void in
                if (error == nil){
                    // update login state
                    self.loginState = LoginState(isLoggedIn: true,
                        subriberHash: result!.root["SubscriberHash"]["SubscriberHash"].stringValue,
                        user: user,
                        password: user)
                    loginHandler(result: result, info: nil, error: error)
                    
                }else{
                    // Login unsuccessful due to network/xml/logincredentials
                    // change login state? only if network error...
                    if (error!.domain == "XMLResponseCode") {
                        print(result!.xmlString)
                    }
                    loginHandler(result: result, info: nil, error: error)
                }
            }
    }
    
    //TODO: Maybe add a convenience function to also deserialize this
    func getDashBoard(dashBoardCompletionHandler:(result:AEXMLDocument?,error:NSError?)->Void)->Void{
        if self.loginState.isLoggedIn{
            self.request(
                JSON(["service":"RequestAppData",
                      "subscriber_hash":self.loginState.subriberHash!]))
                { (result, error) -> Void in
                    if (error == nil){
                        // no error we could parse that xl response
                        dashBoardCompletionHandler(result: result, error: error)
                    }else{
                        dashBoardCompletionHandler(result: nil, error: error)
                    }
            }
        }else{
            dashBoardCompletionHandler(result: nil, error: NSError(domain: "getDashBoard", code: 1, userInfo: ["text":"NotLoggedinError"]))
        }
    }
        
}