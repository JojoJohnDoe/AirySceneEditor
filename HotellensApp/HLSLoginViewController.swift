//
//  HLSLoginViewController.swift
//  HotellensApp
//
//  Created by Johannes Karow on 26/08/14.
//  Copyright (c) 2014 Hotellens. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleAnalytics_iOS_SDK

class HLSLoginViewController: GAITrackedViewController{
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Send hits to Google Analytics
        self.screenName = "Login"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        
        
        let user = "user@user.com" //username.text
        let password = "password" //password.text
        
        let api = APIManager.sharedInstance
        api.login(user, password: password){(result:AEXMLDocument?,info:JSON?, error:NSError?)->Void in
            if (error == nil){
                self.loginWasSuccessfull()
            }else{
                // TODO: Should maybe show meaningful error which tells what actually happened
                var alert = UIAlertController(title: NSLocalizedString("Login_failed!", comment: ""), message: NSLocalizedString("Wrong_Username_or_Password.", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("close", comment: ""), style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func loginWasSuccessfull(){
        // call API.loadData or something
        APIManager.sharedInstance.getDashBoard { (result, error) -> Void in
            if (error == nil){
                APIDeserializer().deserializeDashBoard(result!)
                
            }else{
                var alert = UIAlertController(title: NSLocalizedString("DashboardRequest_Failed!", comment:""), message: error?.description, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("close", comment: ""), style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

