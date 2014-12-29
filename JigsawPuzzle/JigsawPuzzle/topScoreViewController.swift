//
//  topScoreViewController.swift
//  JigsawPuzzle
//
//  Created by Jiyu on 10/13/14.
//  Copyright (c) 2014 Jiyu Zhu. All rights reserved.
//

import UIKit

class topScoreViewController: UIViewController {

    @IBOutlet var topScore: UIImageView!
    
    @IBOutlet var mode1_1: UILabel!
    
    @IBOutlet var mode1_2: UILabel!
    
    @IBOutlet var mode1_3: UILabel!
    
    @IBOutlet var mode1_4: UILabel!
    
    @IBOutlet var mode1_5: UILabel!
    
    @IBOutlet var mode2_1: UILabel!
    
    @IBOutlet var mode2_2: UILabel!
    
    @IBOutlet var mode2_3: UILabel!
    
    @IBOutlet var mode2_4: UILabel!
    
    @IBOutlet var mode2_5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mode1_1.text=String(mode1[0])
        mode1_2.text=String(mode1[1])
        mode1_3.text=String(mode1[2])
        mode1_4.text=String(mode1[3])
        mode1_5.text=String(mode1[4])
        
        mode2_1.text=String(mode2[0])
        mode2_2.text=String(mode2[1])
        mode2_3.text=String(mode2[2])
        mode2_4.text=String(mode2[3])
        mode2_5.text=String(mode2[4])
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}
