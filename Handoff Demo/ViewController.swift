//
//  ViewController.swift
//  Handoff Demo
//
//  Created by Somogyi András on 20/01/16.
//  Copyright © 2016 Andras Somogyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    var messageText: NSString! = ""
    
    // MARK: Lifecycle methods
    override func viewDidAppear(animated: Bool) {
        // Setting up the text field
        textField.placeholder = "Type something!"
        textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activity = NSUserActivity(activityType: "sa.Handoff-Demo.text")
        activity.title = "Message"
        activity.userInfo = ["text": ""]
        userActivity = activity
        userActivity?.becomeCurrent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: User activity methods
    override func updateUserActivityState(activity: NSUserActivity) {
        activity.addUserInfoEntriesFromDictionary(["text": messageText])
        super.updateUserActivityState(activity)
    }
    
    override func restoreUserActivityState(activity: NSUserActivity) {
        textField.text = activity.userInfo?["text"] as? String
    }
    
    // MARK: UITextFieldDelegate methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        messageText = (textField.text as NSString!).stringByReplacingCharactersInRange(range, withString: string)
        self.updateUserActivityState(userActivity!)
        return true
    }
}

