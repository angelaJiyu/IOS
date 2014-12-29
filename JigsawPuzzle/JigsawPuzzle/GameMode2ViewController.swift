//
//  gameMode2ViewController.swift
//  jigsaw puzzle
//
//  Created by Jiyu on 14-10-5.
//  Copyright (c) 2014年 Jiyu Zhu. All rights reserved.
//

import UIKit

class GameMode2ViewController: UIViewController {
    
    var fragNameList: [String] = ["taj_", "rus_", "capitol_", "tiantan_", "wall_", "ben_", "af_", "rome_", "nyc_"]
    
    @IBOutlet var nameTitle: UILabel!
    
    @IBOutlet var stepTitle: UILabel!
    
    @IBOutlet var playerName: UILabel!
    
    @IBOutlet var playerStep: UILabel!
    
    var imageView_1: UIImageView = UIImageView()
    
    var imageView_2: UIImageView = UIImageView()
    
    var imageView_3: UIImageView = UIImageView()
    
    var imageView_4: UIImageView = UIImageView()
    
    var imageView_5: UIImageView = UIImageView()
    
    var imageView_6: UIImageView = UIImageView()
    
    var imageView_7: UIImageView = UIImageView()
    
    var imageView_8: UIImageView = UIImageView()
    
    var imageView_9: UIImageView = UIImageView()
    
    var winImageView: UIImageView = UIImageView()
    
    var imageViewLocIndList: [Int] = []
    
    var imageViewLocList: [[Int]] = [[60, 165],[160, 165],[260, 165],[60, 265],[160, 265],[260, 265],[60, 365],[160, 365],[260, 365]]
    
    var imageViewList: [UIImageView] = []
    
    var panRectList: [UIPanGestureRecognizer] = []
    
    var imageViewAngleList: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    var fragIndList: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    
    var fragSetInd = Int(arc4random_uniform(9))
    
    var isPlaying = false
    
    
    var tapRec1 = UITapGestureRecognizer()
    var tapRec2 = UITapGestureRecognizer()
    var tapRec3 = UITapGestureRecognizer()
    var tapRec4 = UITapGestureRecognizer()
    var tapRec5 = UITapGestureRecognizer()
    var tapRec6 = UITapGestureRecognizer()
    var tapRec7 = UITapGestureRecognizer()
    var tapRec8 = UITapGestureRecognizer()
    var tapRec9 = UITapGestureRecognizer()
    
    var panRec1 = UIPanGestureRecognizer()
    var panRec2 = UIPanGestureRecognizer()
    var panRec3 = UIPanGestureRecognizer()
    var panRec4 = UIPanGestureRecognizer()
    var panRec5 = UIPanGestureRecognizer()
    var panRec6 = UIPanGestureRecognizer()
    var panRec7 = UIPanGestureRecognizer()
    var panRec8 = UIPanGestureRecognizer()
    var panRec9 = UIPanGestureRecognizer()
    
    var rotateCorrect = false
    
    var isWin = false
    
    var tapRecList: [UITapGestureRecognizer] = []
    var panRecList: [UIPanGestureRecognizer] = []
    
    
    @IBAction func playButton(sender: AnyObject) {
        
        if (!isPlaying && !isWin) {
            
            imageViewLocIndList = shuffle(imageViewLocIndList)
            var i: Int
            for (i = 0; i < 9; i++) {
                imageViewList[i].center.x = CGFloat(imageViewLocList[imageViewLocIndList[i]][0])
                imageViewList[i].center.y = CGFloat(imageViewLocList[imageViewLocIndList[i]][1])
                
            }
            
            
            for (i = 0; i < 9; i++) {
                imageViewAngleList[i] = Int(arc4random_uniform(4))
                imageViewList[i].transform = CGAffineTransformMakeRotation(CGFloat(Double(imageViewAngleList[i]) * M_PI_2))
            }
            
            isPlaying = true
        }
        
    }
    
    
    
    func tappedView(sender:UITapGestureRecognizer) {
        
        if (isPlaying && !rotateCorrect) {
            
            var x = sender.view!.center.x
            var y = sender.view!.center.y
            var tappedCol = Int((x - 60) / 100)
            var tappedRow = Int((y - 165) / 100)
            
            var i = find(imageViewLocIndList, tappedCol + 3 * tappedRow)
            
            imageViewAngleList[i!] += 1
            imageViewList[i!].transform = CGAffineTransformMakeRotation(CGFloat(Double(imageViewAngleList[i!]) * M_PI_2))
            
            p.step++
            playerStep.text = String(p.step)
            
            for (var i = 0; i < 9; i++) {
                if (imageViewAngleList[i] % 4 != 0) {
                    rotateCorrect = false
                    return
                }
            }
            rotateCorrect = true
        }
    }
    

    func pannedView(sender:UIPanGestureRecognizer) {
        if (isPlaying && rotateCorrect) {
            
            var panInd = find(panRecList, sender)
            
            var translation = sender.translationInView(self.view)
            sender.view!.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
            
            sender.setTranslation(CGPointZero, inView: self.view)
            if(sender.state == UIGestureRecognizerState.Ended) {
                
                p.step++
                playerStep.text = String(p.step)
                
                for (var i = 0; i < 9; i++) {
                    if (abs(Int(sender.view!.center.x) - imageViewLocList[i][0]) <= 40 && abs(Int(sender.view!.center.y) - imageViewLocList[i][1]) <= 40) {
                        sender.view!.center.x = CGFloat(imageViewLocList[i][0])
                        sender.view!.center.y = CGFloat(imageViewLocList[i][1])
                        panRecList[panInd!].view!.center.x = sender.view!.center.x
                        panRecList[panInd!].view!.center.y = sender.view!.center.y
                        
                        if (checkWin()) {
                            println("Win!")
                            winImageView.image = UIImage(named: "win.jpg")
                            winImageView.center.x = CGFloat(160)
                            winImageView.center.x = CGFloat(260)
                            view.addSubview(winImageView)
                            for (var i = 0; i < 5; i++) {
                                if (p.step <= mode2[i]) {
                                    var temp = mode2[i]
                                    for (var j = 4; j > i; j--) {
                                        mode2[j] = mode2[j - 1]
                                    }
                                    mode2[i] = p.step
                                    break
                                }
                            }
                            isWin = true
                            isPlaying = false
                        }
                        return
                    }
                }
            }
        }
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // add the gesture recongnizer
        self.tapRec9.addTarget(self, action: "tappedView:")
        self.tapRec8.addTarget(self, action: "tappedView:")
        self.tapRec7.addTarget(self, action: "tappedView:")
        self.tapRec6.addTarget(self, action: "tappedView:")
        self.tapRec5.addTarget(self, action: "tappedView:")
        self.tapRec4.addTarget(self, action: "tappedView:")
        self.tapRec3.addTarget(self, action: "tappedView:")
        self.tapRec2.addTarget(self, action: "tappedView:")
        self.tapRec1.addTarget(self, action: "tappedView:")
        self.imageView_9.addGestureRecognizer(tapRec9)
        self.imageView_9.userInteractionEnabled = true
        self.imageView_8.addGestureRecognizer(tapRec8)
        self.imageView_8.userInteractionEnabled = true
        self.imageView_7.addGestureRecognizer(tapRec7)
        self.imageView_7.userInteractionEnabled = true
        self.imageView_6.addGestureRecognizer(tapRec6)
        self.imageView_6.userInteractionEnabled = true
        self.imageView_5.addGestureRecognizer(tapRec5)
        self.imageView_5.userInteractionEnabled = true
        self.imageView_4.addGestureRecognizer(tapRec4)
        self.imageView_4.userInteractionEnabled = true
        self.imageView_3.addGestureRecognizer(tapRec3)
        self.imageView_3.userInteractionEnabled = true
        self.imageView_2.addGestureRecognizer(tapRec2)
        self.imageView_2.userInteractionEnabled = true
        self.imageView_1.addGestureRecognizer(tapRec1)
        self.imageView_1.userInteractionEnabled = true
        
        self.panRec9.addTarget(self, action: "pannedView:")
        self.panRec8.addTarget(self, action: "pannedView:")
        self.panRec7.addTarget(self, action: "pannedView:")
        self.panRec6.addTarget(self, action: "pannedView:")
        self.panRec5.addTarget(self, action: "pannedView:")
        self.panRec4.addTarget(self, action: "pannedView:")
        self.panRec3.addTarget(self, action: "pannedView:")
        self.panRec2.addTarget(self, action: "pannedView:")
        self.panRec1.addTarget(self, action: "pannedView:")
        self.imageView_9.addGestureRecognizer(panRec9)
        self.imageView_9.userInteractionEnabled = true
        self.imageView_8.addGestureRecognizer(panRec8)
        self.imageView_8.userInteractionEnabled = true
        self.imageView_7.addGestureRecognizer(panRec7)
        self.imageView_7.userInteractionEnabled = true
        self.imageView_6.addGestureRecognizer(panRec6)
        self.imageView_6.userInteractionEnabled = true
        self.imageView_5.addGestureRecognizer(panRec5)
        self.imageView_5.userInteractionEnabled = true
        self.imageView_4.addGestureRecognizer(panRec4)
        self.imageView_4.userInteractionEnabled = true
        self.imageView_3.addGestureRecognizer(panRec3)
        self.imageView_3.userInteractionEnabled = true
        self.imageView_2.addGestureRecognizer(panRec2)
        self.imageView_2.userInteractionEnabled = true
        self.imageView_1.addGestureRecognizer(panRec1)
        self.imageView_1.userInteractionEnabled = true
        
        self.playerName.text = p.playerName
        self.playerStep.text = String(p.step)
        
        imageViewList = [imageView_1, imageView_2, imageView_3, imageView_4, imageView_5, imageView_6, imageView_7, imageView_8, imageView_9]
        
        panRecList = [panRec1, panRec2, panRec3, panRec4, panRec5, panRec6, panRec7, panRec8, panRec9]
        
        var fragSetName = fragNameList[fragSetInd]
        var i: Int
        for (i = 0; i < 9; i++) {
            var k = String(i + 1)
            var image = UIImage(named: fragSetName + k + ".jpg")
            imageViewList[i].image = image
            imageViewList[i].frame = CGRectMake(0, 0, 100, 100)
            imageViewList[i].center.x = CGFloat(60 + (i % 3) * 100)
            imageViewList[i].center.y = CGFloat(165 + (i / 3) * 100)
            
            panRecList[i].view!.center.x = imageViewList[i].center.x
            panRecList[i].view!.center.y = imageViewList[i].center.y
            
            self.view.addSubview(imageViewList[i])
        }
        
        imageViewLocIndList = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        
        isPlaying = false

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkWin() -> Bool {
        for (var i = 0; i < 9; i++) {
            if (Int(panRecList[i].view!.center.x) != imageViewLocList[i][0] || Int(panRecList[i].view!.center.y) != imageViewLocList[i][1]) {
                return false
            }
        }
        return true
    }

    

}

