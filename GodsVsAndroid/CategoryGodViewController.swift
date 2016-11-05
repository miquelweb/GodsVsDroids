//
//  CategoryGodViewController.swift
//  GodsVsAndroid
//
//  Created by Miquel Viladomat on 5/11/16.
//  Copyright © 2016 Miquel Viladomat. All rights reserved.
//

import UIKit

class CategoryGodViewController: UIViewController {
    var pos: Int = 1
    @IBOutlet weak var bgImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prevBtnPress(_ sender: Any) {
        pos -= 1
        if pos < 1 {
            pos = 3
        }
        showImage()
    }
    @IBAction func nextBtnPress(_ sender: Any) {
        pos += 1
        if pos > 3 {
            pos = 1
        }
        showImage()
    }
    func showImage(){
        switch pos {
        case 1:
            bgImageView.image = UIImage(named:"screen_creacio_faccio_GOD_warrior-01.png")
            break
        case 2:
            bgImageView.image = UIImage(named:"screen_creacio_faccio_GOD_profet-01.png")
            break
        case 3:
            bgImageView.image = UIImage(named:"screen_creacio_faccio_GOD_spy-01.png")
            break
        default:
            break
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ProfileSegue" {
            switch pos {
            case 1:
                UserDefaults.standard.set("Warrior", forKey:"PlayerCategory")
                break
            case 2:
                UserDefaults.standard.set("Profet", forKey:"PlayerCategory")
                break
            case 3:
                UserDefaults.standard.set("Spy", forKey:"PlayerCategory")
                break
            default:
                break
            }
        }

        
    }

}
