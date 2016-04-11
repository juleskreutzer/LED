//
//  HttpRequest.swift
//  LED
//
//  Created by Jules Kreutzer on 11-04-16.
//  Copyright © 2016 Jules Kreutzer. All rights reserved.
//

import Foundation
import Cocoa

public class HttpRequest {
    
    public static func doChangeColor(color newColorToChangeTo: NSColor) throws -> Void {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let ip = defaults.stringForKey("serverAddress")
        
        if ip == nil || ip == "" {
            throw LedError.NO_SERVER_IP_ADDRESS
        }
        
        let url = "\(ip!)/hello"
        let request = NSMutableURLRequest(URL: NSURL(string:url)!)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler:  { (data, response, error) -> Void in
            
            if(error != nil) {
                print(error)
            }
            else {
                let httpResponse = response as? NSHTTPURLResponse
                print(httpResponse)
                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Data: \(dataString)")
            }
        })
        
        dataTask.resume()
    }
}