//
//  FriendRequestResponseController.swift
//  Created by trinitor
//  Copyright (c) 2015 trinitor.de. All rights reserved.
//

import UIKit

class FriendRequestResponseController: UIViewController, APIControllerProtocol, UITableViewDelegate, UITableViewDataSource {
   
    var friends:NSMutableArray = NSMutableArray()
    var items = NSMutableArray()
    
    @IBOutlet weak var tableView: UITableView!

    var api = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api.delegate = self;
        api.getOpenFriendrequests()
        
        tableView.delegate = self
        tableView.dataSource = self
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
        
        var friends:JSON = JSON(results)
        let resultJson = friends["friendrequests"]
        for (index: String, subJson: JSON) in resultJson {
            println("subJson: \(subJson.object)")
            let friend: AnyObject = subJson.object
            self.items.addObject(friend)
        }
        
        println("resultJson: \(resultJson)")
        println("items: \(items)")
        
        tableView?.reloadData()
    }
    
    @IBAction func CancelButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddFriendView") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("items count: \(self.items.count)")
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        let friend:JSON =  JSON(self.items[indexPath.row])
        cell!.textLabel?.text = friend["friend_name"].string
        
        return cell!
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("prepareForSegue segue.identifier: \(segue.identifier)")
        if let identifier = segue.identifier {
            println("identifier \(identifier)")

            if identifier == "showFriendRequestDetails" {
                
                var destination = segue.destinationViewController as! FriendRequestResponseDetailsController
                
                if let indexPath = self.tableView.indexPathForSelectedRow() {
                    var row = indexPath.row
                    println("row: \(row)")
                    let friend:JSON =  JSON(self.items[row])
                    println("friend: \(friend)")
                    var friendname = friend["friend_name"].string
                    println("friend_name: \(friendname)")
                    destination.friendName = friend["friend_name"].string!
                }
            }
        }
    }
}