//
//  AddFriendController.swift
//  Created by trinitor
//  Copyright (c) 2015 trinitor.de. All rights reserved.
//

import UIKit

class AddFriendController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @IBAction func CancelButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TabView") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
}