//
//  DataViewController.swift
//  Created by trinitor
//  Copyright (c) 2015 trinitor.de. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // if user is not logged in open the login view
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

        if (defaults.valueForKey("username") == nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LoginView") as! UIViewController
            self.presentViewController(vc, animated: false, completion: nil)
        }
        
        // send push token to api if it exists
        PushNotification.sendToken()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

