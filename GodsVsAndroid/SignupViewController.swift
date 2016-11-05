//
//  SignupViewController.swift
//  GodsVsAndroid
//
//  Created by Miquel Viladomat on 5/11/16.
//  Copyright © 2016 Miquel Viladomat. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userTxt: UITextField!
    @IBOutlet weak var nickTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPasswordTxt: UITextField!
    @IBOutlet weak var sendView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userTxt.delegate = self
        nickTxt.delegate = self
        passwordTxt.delegate = self
        repeatPasswordTxt.delegate = self
        
        sendView.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 100)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 100)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }

    @IBAction func enterPress(_ sender: Any) {
        sendView.isHidden = false
    }
    


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DoneSegue" {
            
            UserDefaults.standard.set(userTxt.text, forKey:"PlayerEmail")
            UserDefaults.standard.set(nickTxt.text, forKey:"PlayerName")
        }
        if segue.identifier == "LaterSegue" {
            
            UserDefaults.standard.set(userTxt.text, forKey:"PlayerEmail")
            UserDefaults.standard.set(nickTxt.text, forKey:"PlayerName")
        }
     
    }
 

}
