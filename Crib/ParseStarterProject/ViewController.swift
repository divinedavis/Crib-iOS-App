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
import Foundation



class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    

    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    var signupActive : Bool = true
    
    func displayAlert(title : String, error : String) {
        
        
        let alert = UIAlertController(title: "Something is wrong", message: error, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            self.dismissViewControllerAnimated(true, completion: nil)}))
        
        self.presentViewController(alert, animated: true, completion: nil)

    }
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signupLabel: UILabel!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var signupToggleButton: UIButton!
    
    @IBOutlet weak var alreadyRegistered: UILabel!
    
    @IBAction func toggleSignup(sender: AnyObject) {
        
        if signupActive == true {
            
            signupActive = false
            
            signupLabel.text = "Use the form below to log in"
            
            signupButton.setTitle("Log in", forState: UIControlState.Normal)
            
            alreadyRegistered.text = "Not registered?"
            
            signupToggleButton.setTitle("Sign up", forState: UIControlState.Normal)
            
        } else {
            signupActive = true
            
            signupLabel.text = "Use the form below to sign up"
            
            signupButton.setTitle("Sign up", forState: UIControlState.Normal)
            
            alreadyRegistered.text = "Already registered?"
            
            signupToggleButton.setTitle("Log in", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func signup(sender: AnyObject) {
        
        var error = ""
        
        if username.text == "" || password.text == "" {
            
            error = "Please enter a username & password"
        }
        
        if error != "" {
            
            displayAlert("Error in the credentials you entered", error: error)
        
        } else {
            
            var user = PFUser()
            
            user.username = username.text
            user.password = password.text
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
           
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            
            if signupActive == true {
            
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool, signupError: NSError?) -> Void in
                
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                    if signupError == nil {
                        
                        print("signed up")
                        
                        } else {
                    
                        if let errorString = signupError?.userInfo["error"] as? NSString {
                        
                            error = errorString as String
                        
                        } else {

                        error = "Please try again later"
                        
                        }
                    
                        self.displayAlert("Could not sign up", error: error)
                    }
                }
            } else {
        
                PFUser.logInWithUsernameInBackground(username.text!, password : password.text!) {
                (user: PFUser?, signupError: NSError?) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if signupError == nil {
                    
                    print("logged in")
                    
                } else {
                    
                    if let errorString = signupError!.userInfo["error"] as? NSString {
                    
                    error = errorString as String
                    
                    } else {
                        error = "Please try again later"
                    }
                
                self.displayAlert("Could not log in", error: error)
                    
                }
            }
        }
    }
}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(PFUser.currentUser()!)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
//        if PFUser.currentUser() != nil {
//            
//            self.performSegueWithIdentifier("jumpToUserTable", sender: self)
//            
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
