//
//  ProfileViewController.swift
//  GodsVsAndroid
//
//  Created by Miquel Viladomat on 5/11/16.
//  Copyright © 2016 Miquel Viladomat. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var energy:String = ""
    var attack:String = ""
    var defense:String = ""
    var health:String = ""
    var wisdom:String = ""

    
    @IBOutlet weak var energyLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var healthLbl: UILabel!
    @IBOutlet weak var wisdomLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        energyLbl.isHidden = true
        attackLbl.isHidden = true
        defenseLbl.isHidden = true
        healthLbl.isHidden = true
        wisdomLbl.isHidden = true
        
        if energy != "" {
            energyLbl.text = energy
            energyLbl.isHidden = false
        }
        if attack != "" {
            attackLbl.text = attack
            attackLbl.isHidden = false
        }
        if defense != "" {
            defenseLbl.text = defense
            defenseLbl.isHidden = false
        }
        if health != "" {
            healthLbl.text = health
            healthLbl.isHidden = false
        }
        if wisdom != "" {
            wisdomLbl.text = wisdom
            wisdomLbl.isHidden = false
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
