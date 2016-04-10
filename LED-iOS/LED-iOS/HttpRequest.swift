//
//  HttpRequest.swift
//  LED-iOS
//
//  Created by Jules Kreutzer on 05-04-16.
//  Copyright © 2016 Jules Kreutzer. All rights reserved.
//

import Foundation
import UIKit

public class HttpRequest {
    
    public static func doChangeColor(color newColorToChangeTo: UIColor) throws -> Void {
        
        // How about a broadcast
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let ip = defaults.stringForKey("serverIp")
        
        if (ip == nil || ip == "") {
            throw LedError.NO_SERVER_IP_ADDRESS
        }
        
        let request = NSMutableURLRequest(URL: NSURL(string: "\(ip)/hello")!)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? NSHTTPURLResponse
                print(httpResponse)
            }
        })
        
        dataTask.resume()
        
    }
}
