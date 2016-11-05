//
//  SwordsViewController.swift
//  GodsVsAndroid
//
//  Created by Miquel Viladomat on 4/11/16.
//  Copyright © 2016 Miquel Viladomat. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox

class SwordsViewController: UIViewController {
    
    @IBOutlet weak var gestureImg: UIImageView!
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var droidWinsImageView: UIImageView!
    @IBOutlet weak var splatterImageView: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var bgWebView: UIWebView!
    var motionManager: CMMotionManager!
    var time: Double = 0.0
    var step: Int = 0
    var demon: Int = 0
    
    @IBOutlet weak var stepLbl: UILabel!
    let bigSensor: Double = 0.7
    let smallSensor: Double = 0.2
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager = CMMotionManager()
        
        splatterImageView.isHidden = true
        droidWinsImageView.isHidden = true
        redView.isHidden = true
        finishBtn.isHidden = true
        
        bgImageView.image =  UIImage(named: "demon_" + String(demon) + "_sword.png")
        
        let filePath = Bundle.main.path(forResource: "demon_" + String(demon) + "_sword", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        
        
        bgWebView.load(gif! as Data, mimeType: "image/gif", textEncodingName: String(), baseURL: NSURL() as URL)
        
        
        
        bgWebView.isUserInteractionEnabled = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        sleep(1)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        let systemSoundID: SystemSoundID = 1013
        AudioServicesPlaySystemSound (systemSoundID)
        sleep(1)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        AudioServicesPlaySystemSound (systemSoundID)
        sleep(1)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        AudioServicesPlaySystemSound (systemSoundID)
        
        self.bgImageView.isHidden = true
        
        self.gestureImg.image = UIImage(named: "BattleC_0.png")
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            step=0
            
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { deviceManager, error in
                self.time += 1
                                
                switch self.step{
                case 0:
                    
                    if ((deviceManager?.userAcceleration.x)! < Double(-self.bigSensor)) &&
                        ((deviceManager?.userAcceleration.y)! < Double(self.smallSensor)) &&
                        ((deviceManager?.userAcceleration.y)! > Double(-self.smallSensor)) &&
                        ((deviceManager?.userAcceleration.z)! < Double(self.smallSensor)) &&
                        ((deviceManager?.userAcceleration.z)! > Double(-self.smallSensor)) {
                        //self.stepLbl.text = "1"
                        self.gestureImg.image = UIImage(named: "BattleC_1.png")
                        self.step = 1
                    }
                    break
                case 1:
                    if ((deviceManager?.userAcceleration.y)! > Double(self.bigSensor)) &&
                        ((deviceManager?.userAcceleration.x)! < Double(self.smallSensor)) &&
                        ((deviceManager?.userAcceleration.x)! > Double(-self.smallSensor)) &&
                        ((deviceManager?.userAcceleration.z)! < Double(self.smallSensor)) &&
                        ((deviceManager?.userAcceleration.z)! > Double(-self.smallSensor)) {
                        self.gestureImg.image = UIImage(named: "BattleC_2.png")
                        self.step = 2
                    }
                    
                    break
                    
                case 2:
                    if ((deviceManager?.userAcceleration.x)! < Double(-self.bigSensor)) &&
                        ((deviceManager?.userAcceleration.y)! < Double(self.smallSensor)) &&
                        ((deviceManager?.userAcceleration.y)! > Double(-self.smallSensor)) &&
                        ((deviceManager?.userAcceleration.z)! < Double(self.smallSensor)) &&
                        ((deviceManager?.userAcceleration.z)! > Double(-self.smallSensor)) {
                        self.gestureImg.image = UIImage(named: "BattleC_3.png")
                        self.step = 3
                    }
                    
                    break
                    
                case 3:
                    if ((deviceManager?.userAcceleration.z)! < Double(-self.bigSensor)) &&
                        ((deviceManager?.userAcceleration.x)! < Double(self.bigSensor)) &&
                        ((deviceManager?.userAcceleration.x)! > Double(-self.bigSensor)) &&
                        ((deviceManager?.userAcceleration.y)! < Double(self.bigSensor)) &&
                        ((deviceManager?.userAcceleration.y)! > Double(-self.bigSensor)) {
                        self.gestureImg.image = UIImage(named: "BattleC_4.png")
                        
                        self.bgImageView.isHidden = false
                        self.step = 4
                        
                        self.motionManager.stopDeviceMotionUpdates()
                        print( String (self.time))
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.gestureImg.isHidden = true;
                            
                            if self.time < Double(500){
                                self.bgImageView.image = UIImage(named: "God wins.png")
                                
                            }
                            else{
                                self.splatterImageView.isHidden = false
                                 DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.redView.isHidden = false
                                self.droidWinsImageView.isHidden = false
                                
                                }
                            }
                            self.finishBtn.isHidden = false

                        }
                        
                    }
                    
                    break
                    
                default:
                    
                    break
                    
                    
                }
                if (deviceManager?.userAcceleration.y)! > Double(0.5) {
                    
                }
                // print(String(describing: deviceManager?.userAcceleration.y)) // no print
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
            let dest:ProfileViewController = segue.destination as! ProfileViewController
            if self.time < Double(500){
                dest.defense = "(+1)"
                dest.energy = "(-10)"
            }
            else{
                dest.health = "(-30)"
                dest.energy = "(-10)"
            }
        
    }

}
