//
//  LoginVC.swift
//  ChatApp
//
//  Created by Tuan-Vi Phan on 4/6/16.
//  Copyright © 2016 Tuan-Vi Phan. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    // MARK: IBAction
    @IBAction func loginBtn_click(sender: UIButton) {
        
        PFUser.logInWithUsernameInBackground(usernameTxt.text!, password: passwordTxt.text!) {
            (user: PFUser?, logInError: NSError?) -> Void in
            
            if logInError == nil {
                
                print("log in")
                
                let installation: PFInstallation = PFInstallation.currentInstallation()
                installation["user"] = PFUser.currentUser()
                installation.saveInBackground()
                
                self.performSegueWithIdentifier("goToUsersVC", sender: self)
            } else {
                print("error log in ")
            }
        }
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        usernameTxt.delegate = self
        passwordTxt.delegate = self
        
        welcomeLabel.center = CGPointMake(theWidth/2, 130)
        usernameTxt.frame = CGRectMake(16, 200, theWidth-32, 30)
        passwordTxt.frame = CGRectMake(16, 240, theWidth-32, 30)
        loginBtn.center = CGPointMake(theWidth/2, 330)
        signupBtn.center = CGPointMake(theWidth/2, theHeight-30)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }


}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()

        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        if(UIScreen.mainScreen().bounds.height == 568) {
            if(textField == self.passwordTxt) {
                
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
            if(textField == self.passwordTxt) {
                
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: { () -> Void in
                    
                    self.view.center = CGPointMake(theWidth/2, theHeight/2)
                    }, completion: { (finished: Bool) -> Void in
                        
                        //
                })
            }
        }
    }
}
