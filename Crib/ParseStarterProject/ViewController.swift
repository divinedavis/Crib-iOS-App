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

    var images = UIImagePickerController()
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var pickedImage: UIImageView!

    @IBAction func pickImage(sender: AnyObject) {
        
        images.delegate = self
        images.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        images.allowsEditing = false
        
        self.presentViewController(images, animated: true, completion: nil)
    }
    
    @available(iOS 8.0, *)
    @IBAction func createAlert(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Default", message: "a standard", preferredStyle: .Alert)
        let cancelAlert = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(cancelAlert)
        presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func pause(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
    }
    
    @IBAction func restore(sender: AnyObject) {
        
        activityIndicator.stopAnimating()
        //UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            print("image selected")
            
            pickedImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.dismissViewControllerAnimated(true, completion: nil)
            
            
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
/*
        let score = PFObject(className: "Score")
        score["FirstName"] = "Rob"
        score.saveInBackgroundWithBlock{ (success : Bool, error : NSError?) -> Void in
            print("Saved")
        }
        
        
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if success == true {
            print("Object has been saved. With \(testObject.objectId)")
                
            } else {
                print(error)
            }
        }
        
        var query = PFQuery(className: "Score")
        query.getObjectInBackgroundWithId("cnuKBqSYA6") {
            (score : PFObject?, error: NSError?) -> Void in
            
            if error == nil {
//                print(score?.objectForKey("FirstName"))
                
                
            } else {
                print(error)
            }
        } */
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
