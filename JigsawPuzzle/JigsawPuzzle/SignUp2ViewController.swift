//
//  signUp2ViewController.swift
//  jigsaw puzzle
//
//  Created by Jiyu on 14-10-5.
//  Copyright (c) 2014年 Jiyu Zhu. All rights reserved.
//

import UIKit

class SignUp2ViewController: UIViewController {
    
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet var nameText: UITextField!

    @IBAction func doneButton(sender: AnyObject) {
        self.nameText.endEditing(true)
        p.playerName = self.nameText.text
        p.step = 0
        //     self.dismissViewControllerAnimated(true,completion:nil)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
