//
//  usersVC.swift
//  ChatApp
//
//  Created by Tuan-Vi Phan on 4/6/16.
//  Copyright © 2016 Tuan-Vi Phan. All rights reserved.
//

import UIKit
import Parse

var userName = ""

class usersVC: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var resultsTableView: UITableView!
    
    // MARK: Variables
    var resultsUsernameArray = [String]()
    var resultsProfileNameArray = [String]()
    var resultsImageFiles = [PFFile]()
    
    // MARK: IBAction
    @IBAction func logoutBtn_click(sender: UIBarButtonItem) {
        
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
        resultsTableView.frame = CGRectMake(0, 0, theHeight, theHeight-64)
        
        let messagesBarBtn = UIBarButtonItem(title: "Messages", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("messagesBtn_click"))
        let groupBarBtn = UIBarButtonItem(title: "Group", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("groupBtn_click"))
        let buttonArray = NSArray(objects: messagesBarBtn, groupBarBtn)
        self.navigationItem.rightBarButtonItems = buttonArray as? [UIBarButtonItem]
        
        userName = PFUser.currentUser()!.username!
    }
    
    override func viewDidAppear(animated: Bool) {
        resultsUsernameArray.removeAll(keepCapacity: false)
        resultsProfileNameArray.removeAll(keepCapacity: false)
        resultsImageFiles.removeAll(keepCapacity: false)
        
        let predicate = NSPredicate(format: "username != '"+userName+"'")
        let query = PFQuery(className: "_User", predicate: predicate)
        let objects = try! query.findObjects()
        for object in objects {
            let us: PFUser = object as! PFUser
            self.resultsUsernameArray.append(us.username!)
            self.resultsProfileNameArray.append(object["profileName"] as! String)
            self.resultsImageFiles.append(object["photo"] as! PFFile)
            
            self.resultsTableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }

    // MARK: myfunction
    func messagesBtn_click() {
        print("messages")
        self.performSegueWithIdentifier("goToMessagesVC_FromUsersVC", sender: self)
    }
    
    func groupBtn_click() {
        print("group")
        self.performSegueWithIdentifier("goToGroupVC_FromUsersVC", sender: self)
    }

}

extension usersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsUsernameArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! resultsCell
        
        cell.usernameLbl.text = self.resultsUsernameArray[indexPath.row]
        cell.profileNameLbl.text = self.resultsProfileNameArray[indexPath.row]
        
        resultsImageFiles[indexPath.row].getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            
            if error == nil {
                
                let image = UIImage(data: imageData!)
                cell.profileImg.image = image
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! resultsCell
        
        otherName = cell.usernameLbl.text!
        otherProfileName = cell.profileNameLbl.text!
        self.performSegueWithIdentifier("goToConversationVC", sender: self)
    }
}
