//
//  Player.swift
//  GodsVsAndroid
//
//  Created by Miquel Viladomat on 4/11/16.
//  Copyright © 2016 Miquel Viladomat. All rights reserved.
//

import UIKit

class Player: NSObject {
        
        var name: String
        var team: String
        var strength: Int
        var defense:Int
        var energy:Int
    
        
        init(name: String, team: String, strength:Int, defense:Int, energy:Int) {
            self.name = name
            self.team = team
            self.strength = strength
            self.defense = defense
            self.energy = energy
        }
}
