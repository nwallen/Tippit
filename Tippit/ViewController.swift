//
//  ViewController.swift
//  Tippit
//
//  Created by Nicholas Wallen on 5/15/16.
//  Copyright © 2016 Nicholas Wallen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var tipContainer: UIView!
    
    let currencyFormatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideTip()
        billField.becomeFirstResponder()
        
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.currencyCode = NSLocale.currentLocale().displayNameForKey(NSLocaleCurrencySymbol, value: NSLocaleCurrencyCode)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideTip() {
        self.tipContainer.alpha = 1
        self.tipContainer.frame.origin.y = 400
        self.billField.frame.origin.y = 180
    }
    
    func showTip() {
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut , animations: {
            self.billField.frame.origin.y = 110
            self.tipContainer.alpha = 1
            self.tipContainer.frame.origin.y = 170
        }, completion: nil)
    }

    @IBAction func calculateTip(sender: AnyObject) {
        
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let billText = billField.text!.stringByReplacingOccurrencesOfString(currencyFormatter.currencySymbol, withString: "").stringByReplacingOccurrencesOfString(currencyFormatter.groupingSeparator, withString: "").stringByReplacingOccurrencesOfString(currencyFormatter.decimalSeparator, withString: "")
        
        let bill = Double(billText) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = tip + bill
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip / 100.0)
        totalLabel.text = currencyFormatter.stringFromNumber(total / 100.0)
        billField.text = currencyFormatter.stringFromNumber(bill / 100.0)
        
        showTip()
        
        
    }

}

