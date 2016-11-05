//
//  LoginViewController.swift
//  GodsVsAndroid
//
//  Created by Miquel Viladomat on 5/11/16.
//  Copyright © 2016 Miquel Viladomat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var touchBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTxt.delegate = self
        passwordTxt.delegate = self
        
        // Do any additional setup after loading the view.
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.performSegue(withIdentifier: "MapSegue", sender: nil)
            }
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadData(){
        let userDefaults = UserDefaults.standard
        
        /*if  userDefaults.value(forKey: "PlayerName") != nil {
            let playerName: String = userDefaults.value(forKey: "PlayerName") as! String
            print (playerName)
            performSegue(withIdentifier: "MapSegue", sender: nil)
        }
        else{
            print ("No player")
        }*/
        
    }

    @IBAction func touchBtnPress(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "MapSegue", sender: nil)
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
