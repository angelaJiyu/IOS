//
//  ModeSelectionViewController.swift
//  JigsawPuzzle
//
//  Created by James on 10/6/14.
//  Copyright (c) 2014 Jiyu Zhu. All rights reserved.
//



import UIKit

class ModeSelectionViewController: UIViewController {
    
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var background = UIImage(named: "welcome.jpg")
        self.view.backgroundColor = UIColor(patternImage: background)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
