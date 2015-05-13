//
//  FriendsViewController.swift
//  Created by trinitor 
//  Copyright (c) 2015 trinitor.de. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, APIControllerProtocol, UITableViewDelegate, UITableViewDataSource {

    var friends:NSMutableArray = NSMutableArray()
    var items = NSMutableArray()
    
    @IBOutlet weak var tableView: UITableView!

    var api = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api.delegate = self;
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        friends.removeAllObjects()
        items.removeAllObjects()
        api.getFriends()
    }

    func didRecieveResponse(results: NSDictionary) {
        println("didReceiveResponse results: \(results)")

        var friends:JSON = JSON(results)
        let resultJson = friends["friends"]
        for (index: String, subJson: JSON) in resultJson {
            println("subJson: \(subJson.object)")
            let friend: AnyObject = subJson.object
            self.items.addObject(friend)
        }
        
        println("resultJson: \(resultJson)")
        println("items: \(items)")
        
        tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
        }
        
        let friend:JSON =  JSON(self.items[indexPath.row])
        
        //        let picURL = user["picture"]["medium"].string
        //        let url = NSURL(string: picURL!)
        //        let data = NSData(contentsOfURL: url!)
        
        cell!.textLabel?.text = friend["friend_name"].string
        //        cell?.imageView?.image = UIImage(data: data!)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    @IBAction func AddFriendButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddFriendView") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

}

