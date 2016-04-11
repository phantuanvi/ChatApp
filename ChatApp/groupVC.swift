//
//  groupVC.swift
//  ChatApp
//
//  Created by Tuan-Vi Phan on 4/11/16.
//  Copyright © 2016 Tuan-Vi Phan. All rights reserved.
//

import UIKit
import Parse

class groupVC: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var resultsTable: UITableView!
    
    // MARK: variables
    var resultsNameArray = Set([""])
    var resultsNameArray2 = [String]()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        resultsTable.frame = CGRectMake(0, 0, theWidth, theHeight-64)
        
        resultsTable.dataSource = self
        resultsTable.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        
        groupConversationVC_title = ""
        
        self.resultsNameArray.removeAll(keepCapacity: false)
        self.resultsNameArray2.removeAll(keepCapacity: false)
        
        let query = PFQuery(className: "GroupMessages")
        query.addAscendingOrder("group")
        
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    
                    self.resultsNameArray.insert(object.objectForKey("group") as! String)
                    self.resultsNameArray2 = Array(self.resultsNameArray)
                    self.resultsTable.reloadData()
                }
            }
        }
    }
    
    // MARK: IBAction
    @IBAction func addGroupBtn_click(sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Group", message: "Type the name of the group", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            
        }
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            print("ok pressed")
            let textF = alert.textFields![0]
            let groupMessageObj = PFObject(className: "GroupMessages")
            let theUser: String = PFUser.currentUser()!.username!
            
            groupMessageObj["sender"] = theUser
            groupMessageObj["message"] = "\(theUser) created a new Group"
            groupMessageObj["group"] = textF.text
            
            try! groupMessageObj.save()
            print("group created")
            groupConversationVC_title = textF.text!
            self.performSegueWithIdentifier("goToGroupConversationVC_FromGroupVC", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
            
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

extension groupVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsNameArray2.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupCell") as! groupCell
        
        cell.groupNameLbl.text = resultsNameArray2[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let cell = tableView.cellForRowAtIndexPath(indexPath) as! groupCell
        
        groupConversationVC_title = resultsNameArray2[indexPath.row]
        self.performSegueWithIdentifier("goToGroupConversationVC_FromGroupVC", sender: self)
    }
}
