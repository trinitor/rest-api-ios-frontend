//
//  CreateFriendRequestController.swift
//  Created by trinitor
//  Copyright (c) 2015 trinitor.de. All rights reserved.
//

import UIKit

class FriendRequestCreateController: UIViewController, APIControllerProtocol {
    
    var api = APIController()
    
    @IBOutlet weak var SearchTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api.delegate = self;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didRecieveResponse(results: NSDictionary) {
        println("didReceiveResponse: \(results)")

        var jsonResponse:JSON = JSON(results)
        var title = ""
        var friendRequestStatus = false
        if (jsonResponse["status"] == 400) {
            title = "Error"
        } else {
            title = "Friend request sent"
            friendRequestStatus = true
        }

        let alertController = UIAlertController(title: title, message: "", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            if friendRequestStatus {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("TabView") as! UIViewController
                self.presentViewController(vc, animated: true, completion: nil)
            }
        })
        alertController.addAction(ok)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func SendRequestButton(sender: AnyObject) {
        api.sendFriendRequest(SearchTextfield.text)
    }
    
    @IBAction func CancelButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddFriendView") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func OpenRequestsButton(sender: AnyObject) {
        
    }
    
}