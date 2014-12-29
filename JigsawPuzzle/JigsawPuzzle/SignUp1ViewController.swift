//
//  signUp1ViewController.swift
//  jigsaw puzzle
//
//  Created by Jiyu on 14-10-5.
//  Copyright (c) 2014年 Jiyu Zhu. All rights reserved.
//

import UIKit

class SignUp1ViewController: UIViewController {
    

    @IBOutlet var nameText: UITextField!
    
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
  //  var currentPlayer:player!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        self.nameText.endEditing(true)
        p.playerName = self.nameText.text
        p.step = 0
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent){
        self.view.endEditing(true)

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
