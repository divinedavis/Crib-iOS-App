/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse



class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signup(sender: AnyObject) {
        var error = ""
        
        if username.text == "" || password.text == "" {
            error = "Please enter a username & password"
        }
        
        if error != "" {
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: "Something is wrong", message: error, preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                    self.dismissViewControllerAnimated(true, completion: nil)}))
                
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
            }
            
                
                
            }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
