//
//  FirstViewController.swift
//  RestaurantHub
//
//  Created by Shrujan Kalidindi on 6/16/16.
//  Copyright © 2016 Shrujan Kalidindi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        calculateBtn.layer.cornerRadius = 4 // Button Styling
        calculateBtn.isEnabled = false
        calculateBtn.alpha = 0.5
        
        totalBillTF.keyboardType = .decimalPad // Setting the decimal keyboard (the one with the .) when text fields are clicked
        percentTipTF.keyboardType = .decimalPad
        percentTipTF.text = "15"
        numPeopleTF.text = "1"
        numPeopleTF.keyboardType = .numberPad
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: //tap recognizer that dismisses the keyboard when user taps on screen
            #selector(FirstViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    

    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    @IBAction func totalBillTFChanged(_ sender: AnyObject) {
//        print("TotalBillTF: \(totalBillTF.text)")
        
        if validateField(totalBillTF.text!) && validateField(percentTipTF.text!) && validateField(numPeopleTF.text!) {
            calculateBtn.isEnabled = true
            calculateBtn.alpha = 1
        } else {
            calculateBtn.isEnabled = false
            calculateBtn.alpha = 0.5
        }

    }
    
    
    @IBAction func percentTipTFChanged(_ sender: AnyObject) {
        if validateField(percentTipTF.text!)&&validateField(totalBillTF.text!)&&validateField(numPeopleTF.text!) {
            calculateBtn.isEnabled = true
            calculateBtn.alpha = 1
        } else {
            calculateBtn.isEnabled = false
            calculateBtn.alpha = 0.5
        }
    }
    
    @IBAction func numPeopleTFChanged(_ sender: AnyObject) {
        if validateField(numPeopleTF.text!)&&validateField(totalBillTF.text!)&&validateField(percentTipTF.text!) {
            calculateBtn.isEnabled = true
            calculateBtn.alpha = 1
        } else {
            calculateBtn.isEnabled = false
            calculateBtn.alpha = 0.5
        }
    }

    
    @IBOutlet weak var totalBillTF: UITextField!
    
    @IBOutlet weak var percentTipTF: UITextField!
    
    @IBOutlet weak var numPeopleTF: UITextField!
    
    @IBOutlet weak var calculateBtn: UIButton!
    
    
    @IBAction func calculateBtn(_ sender: UIButton) {
        
        dismissKeyboard()
        
        let startBill = Double(totalBillTF.text!)
        let percent = Double(percentTipTF.text!)
        let numP = Double(numPeopleTF.text!)
        
        
        let tip = Double(startBill!*(percent!/100))
        let tipFinal = String(tip)
        tipTF.text = tipFinal
        
        let finalBill = startBill! + tip
        finalBillTF.text = String(finalBill)
        
        var chargePer = Double(finalBill/numP!)
        chargePer = round((chargePer*100)/100)

        personChargeTF.text = String(chargePer)
        
    }
    
    func validateField(_ text: String) -> Bool {
        var result = true
        
        if text == "" {
            result = false
        } else {
            result = true
        }
        
        
        return result
    }
    
    
    
    @IBOutlet weak var tipTF: UITextField!
    
    @IBOutlet weak var finalBillTF: UITextField!
    
    @IBOutlet weak var personChargeTF: UITextField!
    
    


}

