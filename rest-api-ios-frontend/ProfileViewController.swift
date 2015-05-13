//
//  ProfileViewController.swift
//  Created by trinitor
//  Copyright (c) 2015 trinitor.de. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, APIControllerProtocol {
    
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var AuthTokenLabel: UILabel!
    
    var api = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api.delegate = self;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        api.getProfile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didRecieveResponse(results: NSDictionary) {
        println("didReceiveResponse: \(results)")
        
        UsernameLabel.text = (results["user"]![0]!["name"] as! String)
        AuthTokenLabel.text = (results["user"]![0]!["token"]as! String)
        
        UsernameLabel.hidden = false
        AuthTokenLabel.hidden = false
    }
    
    @IBAction func LogoutButton(sender: AnyObject) {
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("userid")
        defaults.removeObjectForKey("username")
        defaults.removeObjectForKey("auth_token")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("LoginView") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
}

