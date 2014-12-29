//
//  ViewController.swift
//  jigsaw puzzle
//
//  Created by Jiyu on 14-10-5.
//  Copyright (c) 2014年 Jiyu Zhu. All rights reserved.
//

import UIKit
struct Player {
    var playerName = ""
    var step = 0
}
var mode1:[Int]=[9999, 9999, 9999, 9999, 9999]
var mode2:[Int]=[9999, 9999, 9999, 9999, 9999]

var p: Player = Player()

class ViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var background = UIImage(named: "welcome.jpg")
        view.backgroundColor = UIColor(patternImage: background)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

