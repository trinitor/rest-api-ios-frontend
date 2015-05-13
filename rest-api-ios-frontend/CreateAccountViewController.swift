//
//  CreateViewController.swift
//  Created by trinitor
//  Copyright (c) 2015 trinitor.de. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, APIControllerProtocol {
    
    @IBOutlet weak var UsernameTextfield: UITextField!
    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    @IBOutlet weak var Password2Textfield: UITextField!
    
    var api = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api.delegate = self;

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateAccountButton(sender: AnyObject) {
        println("Create account button pressed")

        let parameters:NSDictionary = [
            "user": [
                "name": UsernameTextfield.text,
                "password": PasswordTextfield.text,
                "password_confirmation": Password2Textfield.text
            ]
        ]
        api.CreateUserAccount(parameters)
    }
    
    @IBAction func CancelButton(sender: AnyObject) {
        println("Cancel button pressed")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("LoginView") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func didRecieveResponse(results: NSDictionary) {
        println("didReceiveResponse: \(results)")
        if results["user"] != nil {
            var userid:NSNumber! = results["user"]![0]!["id"] as! NSNumber
            var username:NSString! = results["user"]![0]!["name"] as! NSString
            var auth_token:NSString! = results["user"]![0]!["auth_token"] as! NSString
            
            var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(userid, forKey: "userid")
            defaults.setObject(username, forKey: "username")
            defaults.setObject(auth_token, forKey: "auth_token")
            defaults.synchronize()
            println("user logged in. userid: \(userid), username: \(username), auth_token: \(auth_token)")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("TabView") as! UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        else {
            println("login error")
        }
    }
}

