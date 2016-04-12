//
//  AppDelegate.swift
//  LED
//
//  Created by Jules Kreutzer on 10-04-16.
//  Copyright © 2016 Jules Kreutzer. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var popover: NSPopover!
    
    var monitor : EventMonitor?
    
    let menuItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let launcherAppIndentifier = "nl.nujules.LedLauncherApplication"
        
        SMLoginItemSetEnabled(launcherAppIndentifier, true)
        
        var startedAtLogin = false
        
        for app in NSWorkspace.sharedWorkspace().runningApplications {
            if app.bundleIdentifier == launcherAppIndentifier {
                startedAtLogin = true
            }
        }
        
        if startedAtLogin {
            NSDistributedNotificationCenter.defaultCenter().postNotificationName("killme", object: NSBundle.mainBundle().bundleIdentifier!)
        }
        
        if let button = menuItem.button {
            button.image = NSImage(named: "menuIcon")
            button.action = Selector("togglePopover:")
        }
        
        let mainViewController = NSStoryboard(name: "Main", bundle: nil).instantiateControllerWithIdentifier("mainView") as! ViewController
        
        popover.contentViewController = mainViewController
        
        monitor = EventMonitor(mask: [.LeftMouseDownMask, .RightMouseDownMask]) { [unowned self] event in
            if self.popover.shown {
                self.closePopover(event)
            }
        }
        monitor?.start()
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = menuItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
        monitor?.start()
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        monitor?.stop()
    }

}

