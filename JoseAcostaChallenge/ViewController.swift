//
//  ViewController.swift
//  JoseAcostaChallenge
//
//  Created by MacDalena on 3/8/17.
//  Copyright © 2017 JoseAcosta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        button.isEnabled = false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if ["0","1","2","3","4","5","6","7","8","9"," ","\n","", "-"].contains(text) {
            
            // Enable the button
            button.isEnabled = true
        } else {
            // Dismiss the keyboard
            textView.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let parser = TextParser()
        let grid = parser.parse(textView.text)
        let finder = PathSearch()
        let result = finder.find(grid)
        show(result)
    }
    
    
    fileprivate func show(_ result: (Bool, Int, Array<Int>)) {
        let (success, resistance, path) = result
        
        var message = success ? "Yes" : "No"
        message += "\n" + String(resistance)
        message += "\n" + path.map(){x in String(x)}.joined(separator: " ")
        
        // Create Alert and Add Action
        let alert = UIAlertController(title: "Path of Low Cost", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // Present Alert
        self.present(alert, animated: true, completion: nil)
    }
}
