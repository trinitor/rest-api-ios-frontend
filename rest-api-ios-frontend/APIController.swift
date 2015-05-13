//
//  APIController.swift
//  Created by trinitor
//  Copyright (c) 2015 trinitor.de. All rights reserved.
//

import UIKit

let baseurl = "http://localhost:3000/api/v1/"

protocol APIControllerProtocol {
    func didRecieveResponse(results: NSDictionary)
}

var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
var userid:NSNumber! = defaults.valueForKey("userid") as! NSNumber

class APIController: NSObject {
    var data: NSMutableData = NSMutableData()
    var delegate: APIControllerProtocol?
    
    func buildRequest(url: String!, method: String!, parameters: NSDictionary!) -> NSMutableURLRequest {
        let requestURL:NSURL! = NSURL(string: baseurl + url)
        var request = NSMutableURLRequest(URL: requestURL!)
        request.HTTPMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        if (defaults.valueForKey("auth_token") != nil) {
            var auth_token:NSString = defaults.valueForKey("auth_token")as! NSString
            if (auth_token != "") {
                request.addValue("Token token=\(auth_token)", forHTTPHeaderField: "Authorization")
            }
        }
        
        if parameters != nil
        {
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters!, options: nil, error: nil)
            request.addValue("\(request.HTTPBody!.length)", forHTTPHeaderField: "Content-Length")
        }
        
        println("parameters: \(parameters)")
        println("request URL: \(requestURL)")
        println("requestHeaders: \(request.allHTTPHeaderFields!)")
        if (request.HTTPBody != nil) {
            let debugHTTPBody:NSString! = NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)
            println("debugHTTPBody: \(debugHTTPBody)")
        }
        
        return request
    }
    
    func login(parameters:NSDictionary) {
        var url = "users/login"
        var mutableURLRequest = buildRequest(url, method: "POST", parameters: parameters)
        
        var connection: NSURLConnection = NSURLConnection(request: mutableURLRequest, delegate: self,
            startImmediately: false)!
        
        println("connection to: \(url)")
        
        connection.start()
    }
    
    func sendPushToken(pushtoken:NSString) {
        var url = "users/\(userid)/devices/register"
        let parameters:NSDictionary = [
            "device": [
                "user_id": userid,
                "os": "iOS",
                "push_token": pushtoken
            ]
        ]
        
        var mutableURLRequest = buildRequest(url, method: "POST", parameters: parameters)
        
        var connection: NSURLConnection = NSURLConnection(request: mutableURLRequest, delegate: self,
            startImmediately: false)!
        
        println("connection to: \(url)")
        
        connection.start()
    }
    
    func getFriends() {
        //var userid:NSNumber! = defaults.valueForKey("userid") as NSNumber
        var url = "users/\(userid)/friends"
        var mutableURLRequest = buildRequest(url, method: "GET", parameters: nil)
        
        var connection: NSURLConnection = NSURLConnection(request: mutableURLRequest, delegate: self,
            startImmediately: false)!
        
        println("connection to: \(url)")
        
        connection.start()
    }
    
    func getProfile() {
        var url = "users/\(userid)"
        var mutableURLRequest = buildRequest(url, method: "GET", parameters: nil)
        
        var connection: NSURLConnection = NSURLConnection(request: mutableURLRequest, delegate: self,
            startImmediately: false)!
        
        println("connection to: \(url)")
        
        connection.start()
    }

    func sendFriendRequest(friendname: NSString) {
        var url = "users/\(userid)/friendrequests/\(friendname)"
        var mutableURLRequest = buildRequest(url, method: "POST", parameters: nil)
        
        var connection: NSURLConnection = NSURLConnection(request: mutableURLRequest, delegate: self,
            startImmediately: false)!
        
        println("connection to: \(url)")
        
        connection.start()
    }
    
    func getOpenFriendrequests() {
        //var userid:NSNumber! = defaults.valueForKey("userid") as NSNumber
        var url = "users/\(userid)/friendrequests?status=open_requests"
        var mutableURLRequest = buildRequest(url, method: "GET", parameters: nil)
        
        var connection: NSURLConnection = NSURLConnection(request: mutableURLRequest, delegate: self,
            startImmediately: false)!
        
        println("connection to: \(url)")
        
        connection.start()
    }

    func acceptFriendRequest(friendname: NSString) {
        var url = "users/\(userid)/friendrequests/\(friendname)"
        let parameters:NSDictionary = [
            "friendrequest": [
                "action": "2"
            ]
        ]
        var mutableURLRequest = buildRequest(url, method: "PATCH", parameters: parameters)
        
        var connection: NSURLConnection = NSURLConnection(request: mutableURLRequest, delegate: self,
            startImmediately: false)!
        
        println("connection to: \(url)")
        
        connection.start()
    }
    
    func rejectFriendRequest(friendname: NSString) {
        var url = "users/\(userid)/friendrequests/\(friendname)"
        let parameters:NSDictionary = [
            "friendrequest": [
                "action": "3"
            ]
        ]
        var mutableURLRequest = buildRequest(url, method: "PATCH", parameters: parameters)
        
        var connection: NSURLConnection = NSURLConnection(request: mutableURLRequest, delegate: self,
            startImmediately: false)!
        
        println("connection to: \(url)")
        
        connection.start()
    }
    
    func CreateUserAccount(parameters:NSDictionary) {
        var url = "users"
        var mutableURLRequest = buildRequest(url, method: "POST", parameters: parameters)
        
        var connection: NSURLConnection = NSURLConnection(request: mutableURLRequest, delegate: self,
            startImmediately: false)!
        
        println("connection to: \(url)")
        
        connection.start()
    }
    
    //NSURLConnection delegate method
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("Failed with error:\(error.localizedDescription)")
    }
    
    //NSURLConnection delegate method
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        //New request so we need to clear the data object
        self.data = NSMutableData()
    }
    
    //NSURLConnection delegate method
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        //Append incoming data
        self.data.appendData(data)
    }
    
    //NSURLConnection delegate method
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        //Finished receiving data and convert it to a JSON object
        var err: NSError
        println("connection return data \(data)")
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data,
            options:NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        
        delegate?.didRecieveResponse(jsonResult)
    }
}
