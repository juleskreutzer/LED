//
//  ViewController.swift
//  SwiftColorPicker
//
//  Created by Prashant on 02/09/15.
//  Copyright (c) 2015 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, ColorPickerDelegate {
    
    // outlet - selected color preview
    @IBOutlet var colorPreview: UIView!
    
    
    // outlet - change color button
    @IBOutlet var changeColorButton: UIButton!
    
    // action - called when change color button clicked
    @IBAction func changeColorButtonClicked(sender: UIButton) {
        self.showColorPicker()
    }
    
    // class varible maintain selected color value
    var selectedColor: UIColor = UIColor.blueColor()
    var selectedColorHex: String = "0000FF"
    
    
    
    
    
    // MARK: - View functions
    
    // called after view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    // called if received memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

    
    // MARK: Popover delegate functions

    // Override iPhone behavior that presents a popover as fullscreen.
    // i.e. now it shows same popover box within on iPhone & iPad
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        // show popover box for iPhone and iPad both
        return UIModalPresentationStyle.None
    }
    
    
    
    
    
    // MARK: Color picker delegate functions
    
    // called by color picker after color selected.
    func colorPickerDidColorSelected(selectedUIColor selectedUIColor: UIColor, selectedHexColor: String) {
       
        // update color value within class variable
        self.selectedColor = selectedUIColor
        self.selectedColorHex = selectedHexColor
        
        // set preview background to selected color
        self.colorPreview.backgroundColor = selectedUIColor
        
        // Call the server to change the color of the light
        do {
            try HttpRequest.doChangeColor(color: selectedUIColor)
        } catch LedError.NO_SERVER_IP_ADDRESS {
            showErrorMessage("There's no IP for the server known. Please change this in settings.")
        } catch LedError.INCORRECT_COLOR_FORMAT {
            showErrorMessage("The color you provided, is in an invalid format.")
        } catch {
            showErrorMessage("Something went wrong.")
        }
    }
    
    
    
    
    
    // MARK: - Utility functions
    
    // show color picker from UIButton
    private func showColorPicker(){
        
        // initialise color picker view controller
        let colorPickerVc = storyboard?.instantiateViewControllerWithIdentifier("sbColorPicker") as! ColorPickerViewController
        
        // set modal presentation style
        colorPickerVc.modalPresentationStyle = .Popover
        
        // set max. size
        colorPickerVc.preferredContentSize = CGSizeMake(265, 400)
        
        // set color picker deleagate to current view controller
        // must write delegate method to handle selected color
        colorPickerVc.colorPickerDelegate = self
        
        // show popover
        if let popoverController = colorPickerVc.popoverPresentationController {
            
            // set source view
            popoverController.sourceView = self.view
            
            // show popover form button
            popoverController.sourceRect = self.changeColorButton.frame
            
            // show popover arrow at feasible direction
            popoverController.permittedArrowDirections = UIPopoverArrowDirection.Any
            
            // set popover delegate self
            popoverController.delegate = self
        }
        
        //show color popover
        presentViewController(colorPickerVc, animated: true, completion: nil)
    }
    
    private func showErrorMessage(message: String) {
        let controller = UIAlertController(title: "Oops..", message: message, preferredStyle: .ActionSheet)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        controller.addAction(action)
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    
        

}

