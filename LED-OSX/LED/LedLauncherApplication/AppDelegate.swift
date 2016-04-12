//
//  AppDelegate.swift
//  LedLauncherApplication
//
//  Created by Jules Kreutzer on 12-04-16.
//  Copyright © 2016 Jules Kreutzer. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let LEDIdentifier = "nl.nujules.LED"
        let running = NSWorkspace.sharedWorkspace().runningApplications
        var alreadyRunning = false
        
        for app in running {
            if app.bundleIdentifier == LEDIdentifier {
                alreadyRunning = true
                break
            }
        }
        
        if !alreadyRunning {
            NSDistributedNotificationCenter.defaultCenter().addObserver(self, selector: "terminate", name: "killme", object: LEDIdentifier)
            
            let path = NSBundle.mainBundle().bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("LED")
            
            let newPath = NSString.pathWithComponents(components)
            
            NSWorkspace.sharedWorkspace().launchApplication(newPath)
        }
        else {
            self.terminate()
        }
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func terminate() {
        NSApp.terminate(nil)
    }


}

