//
//  ShootingViewController.swift
//  GodsVsAndroid
//
//  Created by Miquel Viladomat on 4/11/16.
//  Copyright © 2016 Miquel Viladomat. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox

class ShootingViewController: UIViewController {
    @IBOutlet weak var numLabel: UILabel!
    
    @IBOutlet weak var bgWebView: UIWebView!
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var bullImageView: UIImageView!
    @IBOutlet weak var shootImageView: UIImageView!
    @IBOutlet weak var splatterImageView: UIImageView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var droidWinsImageView: UIImageView!
    @IBOutlet weak var finishBtn: UIButton!
    
    @IBOutlet weak var shootBtn: UIButton!
    var motionManager: CMMotionManager!
    var time: Double = 0.0
    var demon: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shootBtn.isHidden = true
        shootImageView.isHidden = true
        redView.isHidden = true
        splatterImageView.isHidden = true
        droidWinsImageView.isHidden = true
        self.numLabel.isHidden = true
        finishBtn.isHidden = true
        
        bgImageView.image = UIImage(named:"demon_" + String(demon) + "_shooting.png")
        
        
        motionManager = CMMotionManager()
        let filePath = Bundle.main.path(forResource: "demon_" + String(demon) + "_shooting", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        
        
        bgWebView.load(gif! as Data, mimeType: "image/gif", textEncodingName: String(), baseURL: NSURL() as URL)
        
        
        
        bgWebView.isUserInteractionEnabled = false

        
               // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.bullImageView.image = UIImage(named:"bull_01.png")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.bullImageView.image = UIImage(named:"bull_02.png")
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.bullImageView.image = UIImage(named:"bull_03.png")
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    self.time = 0.0
        
                    self.bgImageView.isHidden = true
        
                    if self.motionManager.isAccelerometerAvailable {
                        self.motionManager.accelerometerUpdateInterval = 0.1
                        self.motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { deviceManager, error in
                            self.time += 1
                            if (deviceManager?.userAcceleration.y)! > Double(0.5) {
                                self.shootBtn.isHidden = false
                                self.shootImageView.isHidden = false
                                print(String(describing: deviceManager?.userAcceleration.y)) // no print
                            }
                        }
                    }
                }
            }
        }
    }

    @IBAction func shootBtnPress(_ sender: Any) {
        
        motionManager.stopDeviceMotionUpdates()
        self.bgImageView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.bullImageView.isHidden = true
            self.shootImageView.isHidden = true
            self.shootBtn.isHidden = true
            self.numLabel.isHidden = false
            self.numLabel.text = "Your time is " + String (self.time)
            if self.time < Double(200){
                self.bgImageView.image = UIImage(named: "God wins.png")
                
            }
            else{
                self.splatterImageView.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.redView.isHidden = false
                    self.droidWinsImageView.isHidden = false
                    
                }
                
                
                
                
            }
            
            self.finishBtn.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let dest:ProfileViewController = segue.destination as! ProfileViewController
            if self.time < Double(200){
                dest.attack = "(+1)"
                dest.energy = "(-5)"
            }
            else{
                dest.health = "(-20)"
                dest.energy = "(-5)"
            }
        
        
        
    }

}
