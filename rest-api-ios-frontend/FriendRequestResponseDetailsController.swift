//
//  FriendRequestResponseDetailsController.swift
//  Created by trinitor
//  Copyright (c) 2015 trinitor.de. All rights reserved.
//

import UIKit


class FriendRequestResponseDetailsController: UIViewController, APIControllerProtocol {

    var api = APIController()
    var friendName = ""
    
    @IBOutlet weak var friendnameLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        api.delegate = self;
        
        println("friendName: \(friendName)")
        friendnameLabel.text = friendName
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @IBAction func AcceptButton(sender: AnyObject) {
        println("accept friend request")
        
        api.acceptFriendRequest(friendName)
    }
    
    @IBAction func RejectButton(sender: AnyObject) {
        println("reject friend request")

        api.rejectFriendRequest(friendName)
    }
    
    @IBAction func DecideLaterButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TabView") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func didRecieveResponse(results: NSDictionary) {
        println("didReceiveResponse: \(results)")
        
        var jsonResponse:JSON = JSON(results)
        var title = ""
        var friendRequestStatus = false
        if (jsonResponse["status"] == 400) {
            title = "Error"
        } else {
            title = "Respond sent to \(friendName)"
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
}