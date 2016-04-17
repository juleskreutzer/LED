//
//  SettingsViewController.swift
//  LED-iOS
//
//  Created by Jules Kreutzer on 15-04-16.
//  Copyright © 2016 Jules Kreutzer. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var txtServerAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "LaunchImage")
        let imageView = UIImageView(image: image)
        self.navigationItem.titleView = imageView
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openGithubLink(sender: AnyObject) {
        if let url = NSURL(string: "https://github.com/juleskreutzer/LED") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    func dismissKeyboard() {
        let address = txtServerAddress.text
        
        if address == "" {
            let controller = UIAlertController(title: "Wait a second", message: "Leaving the server address open prevents the app from changing LED colors.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            controller.addAction(action)
            
            presentViewController(controller, animated: true, completion: nil)
        } else {
            
        }
        
        view.endEditing(true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didEndOnExit(sender: AnyObject) {
        view.endEditing(true)
    }
}
