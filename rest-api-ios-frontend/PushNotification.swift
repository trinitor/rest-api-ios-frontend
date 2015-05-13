//
//  RegisterPushNotification.swift
//  Created by trinitor
//  Copyright (c) 2015 trinitor.de. All rights reserved.
//

import UIKit

class PushNotification {
    
    class func sendToken() {
        var api = APIController()
        
        // send push token
        println("send push token")
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //var push_token:NSString = defaults.stringForKey("push_token")!
        //if (push_token == "") {
        if let push_token:NSString = defaults.stringForKey("push_token") {
            println("push token exists")
            api.sendPushToken(push_token)
        }
    }
}
