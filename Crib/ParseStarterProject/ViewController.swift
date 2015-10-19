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

    @IBAction func pickImage(sender: AnyObject) {
        
        var image = UIImagePickerController()
        
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
        
        
        
    }
    
    @IBOutlet weak var pickedImage: UIImageView!
    
    
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
