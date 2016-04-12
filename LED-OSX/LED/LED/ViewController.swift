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
    @IBOutlet weak var brightnessSlider: NSSlider!
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
    
    @IBAction func dimLights(sender: AnyObject) {
        HttpRequest.doTurnOffLights()
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if(keyPath == "color") {
            // Detected that the color has changed
            // Call the server to change the led collors
            
            let color = colorWell.color
            
            HttpRequest.doChangeColor(color)
        }
        
    }
    
    @IBAction func sliderDidChange(sender: NSSlider) {
        let brightness = Int(sender.floatValue)
        
        let color = colorWell.color
        
        HttpRequest.brightnessDidChange(color, changeToBrightness: brightness)
    }
    
}
