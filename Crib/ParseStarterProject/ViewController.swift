/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* @author: Divine Davis
 
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
    
    //Making a function that displays an alert when the user does something wrong
    func displayAlert(title : String, error : String) {
        
        let alert = UIAlertController(title: "Uh oh!", message: error, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Alright", style: .Default, handler: { action in
            
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
            
            let user = PFUser()
            
            user.username = username.text
            user.password = password.text
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
           
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            //Checking to see if signupActive is true
            if signupActive == true {
            
                //Since it is true, you'll be able to sign up with this block of code
                user.signUpInBackgroundWithBlock {
                    
                    //Parameters for the block of code
                    (succeeded: Bool, signupError: NSError?) -> Void in
                
                    //When signupActive is true, the animating circle will stop
                    self.activityIndicator.stopAnimating()
                    
                    //Allow the user to use the interface again
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                    //Within this block, while signing up, if signupError doesnt occur, you can sign up
                    if signupError == nil {
                        
                        //Print sign up if you dont receive an error
                        print("signed up")
                        
                        } else {
                    
                        //Creating errorString
                        if let errorString = signupError?.userInfo["error"] as? NSString {
                        
                            //Casting errorString as a Swift object again
                            error = errorString as String
                        
                        } else {

                        //Setting the error text
                        error = "Please try again later"
                        
                        }
                    
                        //Display the alert
                        self.displayAlert("Could not sign up", error: error)
                    }
                }
                
            } else {
        
                //Saving the username and the password as a PFUser
                PFUser.logInWithUsernameInBackground(username.text!, password : password.text!) {
                    
                //Creating a block and an in loop
                (user: PFUser?, signupError: NSError?) -> Void in
                    
                    //Stop the animating circle or 'loading circle'
                    self.activityIndicator.stopAnimating()
                    
                    //Allowing the user to use the interface
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                //If the signupError is not initiated
                if signupError == nil {
                    
                    //If there is no signupError then it will print "logged in"
                    print("logged in")
                    
                } else {
                    
                    //Making errorString as an NSString
                    if let errorString = signupError!.userInfo["error"] as? NSString {
                    
                    //Casting error back to String in Swift from Objective C
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
        
        //Printing the currentUser name
        print(PFUser.currentUser()!)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //If the currentUser is signed in already
        if PFUser.currentUser() != nil {
            
            //Use this segue if the currentUser is logged in
            self.performSegueWithIdentifier("jumpToUserTable", sender: self)    
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
