//
//  SignUpVC.swift
//  ChatApp
//
//  Created by Tuan-Vi Phan on 4/6/16.
//  Copyright © 2016 Tuan-Vi Phan. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // MARK: - IBOutlet
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var addImgBtn: UIButton!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var profileNameTxt: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    
    // MARK: - Action
    
    @IBAction func addImgBtn_click(sender: UIButton) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    @IBAction func signupBtn_click(sender: UIButton) {
        
        let user = PFUser()
        user.username = usernameTxt.text
        user.password = passwordTxt.text
        user.email = usernameTxt.text
        user["profileName"] = profileNameTxt.text
        
        let imageData = UIImagePNGRepresentation(self.profileImg.image!)
        let imageFile = PFFile(name: "profilePhoto.png", data: imageData!)
        user["photo"] = imageFile
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, signUpError: NSError?) -> Void in
            
            if signUpError == nil {
                
                print("signup")
            } else {
                
                print("can't signup")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTxt.delegate = self
        passwordTxt.delegate = self
        profileNameTxt.delegate = self

        let theWidth = view.frame.size.width
//        let theHeight = view.frame.size.height
        
        profileImg.center = CGPointMake(theWidth/2, 140)
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        profileImg.clipsToBounds = true
        
        addImgBtn.center = CGPointMake(self.profileImg.frame.maxX+50, 140)
        usernameTxt.frame = CGRectMake(16, 230, theWidth-32, 30)
        passwordTxt.frame = CGRectMake(16, 270, theWidth-32, 30)
        profileNameTxt.frame = CGRectMake(16, 310, theWidth-32, 30)
        signupBtn.center = CGPointMake(theWidth/2, 380)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -Image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        profileImg.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        profileNameTxt.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        if(UIScreen.mainScreen().bounds.height == 568) {
            if(textField == self.profileNameTxt) {
                
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: { () -> Void in
                    
                    self.view.center = CGPointMake(theWidth/2, (theHeight/2)-40)
                    }, completion: { (finished: Bool) -> Void in
                        
                        //
                })
            }
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        if(UIScreen.mainScreen().bounds.height == 568) {
            if(textField == self.profileNameTxt) {
                
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: { () -> Void in
                    
                    self.view.center = CGPointMake(theWidth/2, theHeight/2)
                    }, completion: { (finished: Bool) -> Void in
                        
                        //
                })
            }
        }
    }
}
