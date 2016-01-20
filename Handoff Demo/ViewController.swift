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
    
    // MARK: Lifecycle methods
    override func viewDidAppear(animated: Bool) {
        // Setting up the text field
        textField.placeholder = "Type something!"
        textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activity = NSUserActivity(activityType: "sa.Handoff-Demo.text")
        activity.title = "Note"
        activity.userInfo = ["text": ""]
        userActivity = activity
        userActivity?.becomeCurrent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: User activity methods
    override func updateUserActivityState(activity: NSUserActivity) {
        activity.addUserInfoEntriesFromDictionary(["text": textField.text!])
        super.updateUserActivityState(activity)
    }
    
    override func restoreUserActivityState(activity: NSUserActivity) {
        textField.text = activity.userInfo?["text"] as? String
    }
    
    // MARK: UITextFieldDelegate methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.updateUserActivityState(userActivity!)
        return true
    }
}

