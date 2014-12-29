//
//  GameSelectViewController.swift
//  PhotoAdventure
//
//  Created by James on 11/29/14.
//  Copyright (c) 2014 Bo Ning. All rights reserved.
//

import UIKit

class GameSelectViewController: UIViewController {
    
    var baseImage: UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func spaceButton(sender: AnyObject) {
        if (hasPhoto == false) {
            gameCharactor.image = UIImage(named: "ufo_d.png")
            return
        }
        if (gameCharGender == 1) {
            baseImage = UIImage(named: "ufo_m.png")
        } else {
            baseImage = UIImage(named: "ufo_f.png")
        }
        
    }
    
    
    @IBAction func parashootButton(sender: AnyObject) {
        if (hasPhoto == false) {
            gameCharactor.image = UIImage(named: "para_d.png")
            return
        }
        if (gameCharGender == 1) {
            baseImage = UIImage(named: "para_m.png")
        } else {
            baseImage = UIImage(named: "para_f.png")
        }
        
    }
    
    
    @IBAction func motorButton(sender: AnyObject) {
        if (hasPhoto == false) {
            gameCharactor.image = UIImage(named: "motor_d.png")
            return
        }
        if (gameCharGender == 1) {
            baseImage = UIImage(named: "motor_m.png")
        } else {
            baseImage = UIImage(named: "motor_f.png")
        }
        

    }
    
    
    
}