//
//  ViewController.swift
//  LED
//
//  Created by Jules Kreutzer on 10-04-16.
//  Copyright © 2016 Jules Kreutzer. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var colorWell: NSColorWell!
    @IBOutlet weak var txtServerAddress: NSTextField!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorWell.addObserver(self, forKeyPath: "color", options: NSKeyValueObservingOptions.Initial, context: nil)
        // Do view setup here.
        let address = defaults.stringForKey("serverAddress")
        
        txtServerAddress.stringValue = address == nil ? "" : address!
        
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func saveServerAddress(sender: NSButton) {
        if txtServerAddress.stringValue != "" {
            defaults.setObject(txtServerAddress.stringValue, forKey: "serverAddress")
        }
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if(keyPath == "color") {
            // Detected that the color has changed
            // Call the server to change the led collors
            
            let color = colorWell.color
            
            do {
                try HttpRequest.doChangeColor(color: color)
            } catch(LedError.NO_SERVER_IP_ADDRESS)
            {
                let alert = NSAlert()
                alert.messageText = "Oops"
                alert.addButtonWithTitle("OK")
                alert.informativeText = "Please specify an address to the server."
                
                alert.beginSheetModalForWindow(NSWindow(), completionHandler: nil)
            } catch(LedError.INCORRECT_COLOR_FORMAT)
            {
                let alert = NSAlert()
                alert.messageText = "Oops"
                alert.addButtonWithTitle("OK")
                alert.informativeText = "The provided color was in an incorrect format."
                
                alert.beginSheetModalForWindow(NSWindow(), completionHandler: nil)

                
            } catch {
                
                let alert = NSAlert()
                alert.messageText = "Oops"
                alert.addButtonWithTitle("OK")
                alert.informativeText = "Something went wrong. Please try again."
                
                alert.beginSheetModalForWindow(NSWindow(), completionHandler: nil)

                
            }
        }
        
    }
}
