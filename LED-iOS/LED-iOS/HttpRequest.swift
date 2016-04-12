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
    
    private static func getServerAddress() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let ip = defaults.stringForKey("serverAddress")
        
        if ip == nil || ip == "" {
            return ""
        }
        
        return ip!
    }
    
    public static func doChangeColor(color : UIColor) -> Void {
        let ip = getServerAddress()
        
        let c = color.coreImageColor
        
        let red = Int(round(c!.red * 100))
        let green = Int(round(c!.green * 100))
        let blue = Int(round(c!.blue * 100))
        
        
        let url = "\(ip)/update/\(red)/\(green)/\(blue)"
        print(url)
        
        let request = NSMutableURLRequest(URL: NSURL(string:url)!)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler:  { (data, response, error) -> Void in
            
            if(error != nil) {
                print(error)
            }
        })
        
        dataTask.resume()
    }
    
    public static func doTurnOffLights() -> Void {
        let ip = getServerAddress()
        
        let url = "\(ip)/off"
        let request = NSMutableURLRequest(URL: NSURL(string:url)!)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            if(error != nil) {
                print(error)
            }
        })
        
        dataTask.resume()
        
    }
    
    public static func brightnessDidChange(color : UIColor, changeToBrightness brightness : Int) -> Void {
        
        let ip = getServerAddress()
        
        let c = color.coreImageColor
        
        let red = Int(round(c!.red * 100))
        let green = Int(round(c!.green * 100))
        let blue = Int(round(c!.blue * 100))
        let bn = brightness
        
        let url = "\(ip)/update/brightness/\(red)/\(green)/\(blue)/\(bn)"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if(error != nil) {
                print(error)
            }
        })
        
        dataTask.resume()
        
    }}
