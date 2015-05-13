//
//  LoginViewController.swift
//  Created by trinitor
//  Copyright (c) 2015 trinitor.de. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, APIControllerProtocol {
    
    @IBOutlet weak var UsernameTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    @IBOutlet weak var ErrorMessageLabel: UILabel!
    
    var api = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api.delegate = self;
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(
            self,
            selector: "textFieldTextChanged:",
            name:UITextFieldTextDidChangeNotification,
            object: nil
        )
    }
    
    func textFieldTextChanged(sender : AnyObject) {
        ErrorMessageLabel.hidden = true
        println("user typed something in the textfield")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func LoginButton(sender: AnyObject) {
        println("Login button pressed")
        let parameters:NSDictionary = [
            "user": [
                "name": UsernameTextfield.text,
                "password": PasswordTextfield.text
            ]
        ]
        api.login(parameters)
    }
    
    @IBAction func CreateAccountButton(sender: AnyObject) {
        println("Create account button pressed")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("CreateAccountView") as! UIViewController
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
            ErrorMessageLabel.hidden = false
        }
    }
}

