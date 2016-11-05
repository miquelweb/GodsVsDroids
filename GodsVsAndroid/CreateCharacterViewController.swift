//
//  CreateCharacterViewController.swift
//  GodsVsAndroid
//
//  Created by Miquel Viladomat on 5/11/16.
//  Copyright © 2016 Miquel Viladomat. All rights reserved.
//

import UIKit

class CreateCharacterViewController: UIViewController {

    @IBOutlet weak var godsBtn: UIButton!
    @IBOutlet weak var droidsBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var closeBtn: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    var side: String = "gods"
    override func viewDidLoad() {
        super.viewDidLoad()
        godsBtn.isSelected = true
        modalView.isHidden = true
        bgImageView.image = UIImage(named:"screen_creacio_faccio_god.png")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func godsBtnPress(_ sender: Any) {
        side = "gods"
        bgImageView.image = UIImage(named:"screen_creacio_faccio_god.png")
    }

    @IBAction func droidsBtnPress(_ sender: Any) {
        side = "droids"
        bgImageView.image = UIImage(named:"screen_creacio_faccio_droid.png")
    }
    
    @IBAction func nextBtnPress(_ sender: Any) {
        if side == "droids" {
            modalView.isHidden = false
        }
        else{
            self.performSegue(withIdentifier: "categoryGodSegue", sender: nil)
        }
    }
    @IBAction func closeBtnPress(_ sender: Any) {
        modalView.isHidden = true
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "categoryGodSegue" {
            
            UserDefaults.standard.set("God", forKey:"PlayerFaccio")
        }
        if segue.identifier == "categoryDroidSegue" {
            
            UserDefaults.standard.set("Droid", forKey:"PlayerFaccio")
        }
        
    }


}
