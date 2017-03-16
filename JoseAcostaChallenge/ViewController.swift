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
        enableButton(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if ["0","1","2","3","4","5","6","7","8","9"," ","\n","", "-"].contains(text) {
            //Enable the button if is not empty
            enableButton(true)
            if text.isEmpty && textView.text.characters.count <= 1 {
                enableButton(false)
            }
            
            return true
        } else {
            //Dismiss the keyboard
            textView.resignFirstResponder()
            return false
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if validate(textView.text) {
            let parser = TextParser()
            let grid = parser.parse(textView.text)
            let minCost = MinCostPath()
            let result = minCost.minCost(grid, grid.count - 1, grid[0].count - 1)
            show(result)
        }
        
        
    }
    
    
    fileprivate func show(_ result: (Bool, Int, Array<Int>)) {
        let (success, cost, path) = result
        
        var message = success ? "Yes" : "No"
        message += "\n" + String(cost)
        message += "\n" + path.map(){x in String(x)}.joined(separator: " ")
        
        //Create Alert and Add Action
        let alert = UIAlertController(title: "Path of Low Cost.", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        //Present Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorShow(_ message: String) {
        //Create Alert and Add Action
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        //Present Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //Validate if the current input is a valid grid
    fileprivate func validate(_ input: String) -> Bool {
        var width: Int!
        let rows = input.components(separatedBy: "\n")
        for row in rows {
            let items = row.components(separatedBy: " ")
            
            //clean "" items
            let cleanItems = items.filter({$0 != ""})
            
            if width == nil {
                width = cleanItems.count
            }
            
            if cleanItems.count != width {
                let message = "All rows must have the same number of columns."
                errorShow(message)
                return false
            }
            for item in cleanItems {
                if Int(item) == nil {
                    let message = "At least one of the values is invalid. Please check the input and try again."
                    errorShow(message)
                    return false
                }
            }
        }
        return width != nil
    }
    
    fileprivate func enableButton(_ enabled: Bool) {
        button.isEnabled = enabled
        button.alpha = enabled ? 1 : 0.5
    }
}
