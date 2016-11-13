//
//  ThirdViewController.swift
//  RestaurantHub
//
//  Created by Shrujan Kalidindi on 6/16/16.
//  Copyright © 2016 Shrujan Kalidindi. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveBtn.layer.cornerRadius = 4
        saveBtn.isEnabled = false
        saveBtn.alpha = 0.5
        
        restaurantNameTF.keyboardType = .default
        billTF.keyboardType = .decimalPad
        dateTF.keyboardType = .asciiCapable
        dateTF.autocorrectionType = UITextAutocorrectionType.no
        
        //Removes the modal to go back to go HUB View
        cancelBarItem.target = self
        cancelBarItem.action = #selector(FourthViewController.removeModal(_:))
        
        
        //tap recognizer that dismisses the keyboard when user taps on screen
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(FirstViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //dateTF will always default to today's date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateTF.text = dateFormatter.string(from: Date())
        
    }
    
//    //Moves screen to make way for the keyboard
//    func textFieldDidBeginEditing(textField: UITextField) {
//        animateViewMoving(true, moveValue: 100)
//    }
//    func textFieldDidEndEditing(textField: UITextField) {
//        animateViewMoving(false, moveValue: 100)
//    }
//    
//    func animateViewMoving (up:Bool, moveValue :CGFloat){
//        var movementDuration:NSTimeInterval = 0.3
//        var movement:CGFloat = ( up ? -moveValue : moveValue)
//        UIView.beginAnimations( "animateView", context: nil)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        UIView.setAnimationDuration(movementDuration )
//        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
//        UIView.commitAnimations()
//    }
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        scrollView.setContentOffset(CGPointMake(0, 100), animated: true)
//    }
//    
//    func textFieldDidEndEditing(textField: UITextField) {
//        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
//    }
    
    
    
    
    // UITextFieldDelegate function that basically allows the user to click return on the keyboard and tab through the textfields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == restaurantNameTF {
            billTF.becomeFirstResponder()
        } else if textField == billTF {
            dateTF.becomeFirstResponder()
        } else {
            dateTF.resignFirstResponder()
        }
        return true
    }

    
    //Vars
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cancelBarItem: UIBarButtonItem!
    
    
    @IBOutlet weak var restaurantNameTF: UITextField!
    
    @IBOutlet weak var billTF: UITextField!
    
    
    @IBOutlet weak var saveBtn: UIButton!
    
    
    @IBAction func removeModal(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
    }

    @IBOutlet weak var dateTF: UITextField!
    
    
    //Events
    @IBAction func saveBtnClicked(_ sender: UIButton) {
//        restaurantMGR.addRestaurant(restaurantNameTF.text!, fBill: billTF.text!, date: dateTF.text!)
        let theRestaurant = Restaurant(name: restaurantNameTF.text!, bill: billTF.text!, date: dateTF.text!)
        RestaurantManager.restaurants.append(theRestaurant)
        
        let defaults = UserDefaults.standard
        let myData = NSKeyedArchiver.archivedData(withRootObject: RestaurantManager.restaurants)
        UserDefaults.standard.set(myData, forKey: "restaurantsarray")
        defaults.synchronize()
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //Dismis Keyboard function tht fires on user touch
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    
    
    // Form Validation
    @IBAction func restaurantNameTFChanged(_ sender: AnyObject) {
        if checkTFFilled(restaurantNameTF.text!) && checkTFFilled(billTF.text!) && checkTFFilled(dateTF.text!){
            saveBtn.isEnabled = true
            saveBtn.alpha = 1
        } else {
            saveBtn.isEnabled = false
            saveBtn.alpha = 0.5
        }
    }
    
    @IBAction func billTFChanged(_ sender: AnyObject) {
        if checkTFFilled(billTF.text!) && checkTFFilled(restaurantNameTF.text!) && checkTFFilled(dateTF.text!) {
            saveBtn.isEnabled = true
            saveBtn.alpha = 1
        } else {
            saveBtn.isEnabled = false
            saveBtn.alpha = 0.5
        }
    }
    
    @IBAction func dateTFChanged(_ sender: AnyObject) {
        if checkTFFilled(dateTF.text!) && checkTFFilled(restaurantNameTF.text!) && checkTFFilled(billTF.text!) {
            saveBtn.isEnabled = true
            saveBtn.alpha = 1
        } else {
            saveBtn.isEnabled = false
            saveBtn.alpha = 0.5
        }
    }
    

    @IBAction func dateTFPullUp(_ sender: AnyObject) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
    }
    
    
    @IBAction func dateTFPushDown(_ sender: AnyObject) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    func checkTFFilled(_ text: String) -> Bool {
        var result = true
        if text == "" {
            result = false
        } else {
            result = true
        }
        
        return result
    }
}
