//
//  gameMode1ViewController.swift
//  jigsaw puzzle
//
//  Created by Jiyu on 14-10-5.
//  Copyright (c) 2014年 Jiyu Zhu. All rights reserved.
//

import UIKit

class GameMode1ViewController: UIViewController {
    
    var fragNameList: [String] = ["taj_", "rus_", "capitol_", "tiantan_", "wall_", "ben_", "af_", "rome_", "nyc_"]
    

    @IBOutlet var nameTitle: UILabel!
    
    @IBOutlet var stepTitle: UILabel!
    
    @IBOutlet var playerName: UILabel!
    
    @IBOutlet var playerStep: UILabel!
    
    @IBOutlet var image_1: UIImageView!
    
    @IBOutlet var image_2: UIImageView!

    @IBOutlet var image_3: UIImageView!
    
    @IBOutlet var image_4: UIImageView!
    
    @IBOutlet var image_5: UIImageView!
    
    @IBOutlet var image_6: UIImageView!
    
    @IBOutlet var image_7: UIImageView!
    
    @IBOutlet var image_8: UIImageView!
    
    @IBOutlet var image_9: UIImageView!
    
    @IBOutlet var winimage: UIImageView!
    
    var eightImageList: [UIImageView] = []
    
    var eightPicList: [Int] = [0, 1, 2, 3, 4, 5, 6, 7]
    
    var randomPic = Int(arc4random_uniform(9))
    
    @IBOutlet var winImageView: UIImageView!
    
    var isPlaying: Bool = false
    
    var isWin = false
    
    var emptyImageIndex: Int = 8
    
    let tapRec9 = UITapGestureRecognizer()
    let tapRec8 = UITapGestureRecognizer()
    let tapRec7 = UITapGestureRecognizer()
    let tapRec6 = UITapGestureRecognizer()
    let tapRec5 = UITapGestureRecognizer()
    let tapRec4 = UITapGestureRecognizer()
    let tapRec3 = UITapGestureRecognizer()
    let tapRec2 = UITapGestureRecognizer()
    let tapRec1 = UITapGestureRecognizer()



    @IBAction func playButton(sender: AnyObject) {
        
        if (!isPlaying && !isWin) {

            eightPicList = shuffle([0, 1, 2, 3, 4, 5, 6, 7])
            eightPicList.append(8)
            var picName = fragNameList[randomPic]
            var i: Int
            for (i = 0; i < 9; i++) {
                if (i == 8) {
                    eightImageList[emptyImageIndex].image = nil
                }
                else{
                    var k = String(eightPicList[i] + 1)
                    var image = UIImage(named: picName + k + ".jpg")
                    eightImageList[i].image = image
                    eightImageList[i].frame = CGRectMake(0, 0, 100, 100)
                    eightImageList[i].center.x = CGFloat(60 + (i % 3) * 100)
                    eightImageList[i].center.y = CGFloat(165 + (i / 3) * 100)
                }
            }
            // the empty image is at the bottom right corner
            emptyImageIndex = 8
            isPlaying = true
        }

    }
    
    @IBAction func resetButton(sender: AnyObject) {
        if (isPlaying) {
            eightPicList = shuffle([0, 1, 2, 3, 4, 5, 6, 7])
            eightPicList.append(8)
            var picName = fragNameList[randomPic]
            var i: Int
            for (i = 0; i < 9; i++) {
                if (eightPicList[i] == 8) {
                    eightImageList[emptyImageIndex].image = nil
                }
                else {
                    var k = String(eightPicList[i] + 1)
                    var image = UIImage(named: picName + k + ".jpg")
                    eightImageList[i].image = image
                }
            }
            emptyImageIndex = 8

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
        self.image_9.addGestureRecognizer(tapRec9)
        self.image_9.userInteractionEnabled = true
        self.image_8.addGestureRecognizer(tapRec8)
        self.image_8.userInteractionEnabled = true
        self.image_7.addGestureRecognizer(tapRec7)
        self.image_7.userInteractionEnabled = true
        self.image_6.addGestureRecognizer(tapRec6)
        self.image_6.userInteractionEnabled = true
        self.image_5.addGestureRecognizer(tapRec5)
        self.image_5.userInteractionEnabled = true
        self.image_4.addGestureRecognizer(tapRec4)
        self.image_4.userInteractionEnabled = true
        self.image_3.addGestureRecognizer(tapRec3)
        self.image_3.userInteractionEnabled = true
        self.image_2.addGestureRecognizer(tapRec2)
        self.image_2.userInteractionEnabled = true
        self.image_1.addGestureRecognizer(tapRec1)
        self.image_1.userInteractionEnabled = true
        
        self.playerName.text = p.playerName
        self.playerStep.text = String(p.step)
        eightImageList = [image_1, image_2, image_3, image_4, image_5, image_6, image_7, image_8, image_9]
        
        
        // pick a random picture
        var picName = fragNameList[randomPic]
        var i: Int
        for (i = 0; i < 9; i++) {
            if (i==emptyImageIndex) {
                eightImageList[emptyImageIndex].image = nil
            }
            else {
                var k = String(i + 1)
                var image = UIImage(named: picName + k + ".jpg")
                eightImageList[i].image = image
                eightImageList[i].frame = CGRectMake(0, 0, 100, 100)
                eightImageList[i].center.x = CGFloat(60 + (i % 3) * 100)
                eightImageList[i].center.y = CGFloat(165 + (i / 3) * 100)
            }
        }
        isPlaying = false
        isWin = false

    }

    
    
    func tappedView(sender:UITapGestureRecognizer) {
        
        if (isPlaying) {
        
            var x = sender.view!.center.x
            var y = sender.view!.center.y
            var tapViewIndex = Int((x - 60) / 100) + (Int((y - 165) / 100)) * 3
        
            var tapCol = Int((x - 60) / 100)
            var tapRow = Int((y - 165) / 100)
        
            // emptyImageIndex
            var row = Int(emptyImageIndex / 3)
            var col = Int(emptyImageIndex % 3)
        
            var i: Int
            var picName = fragNameList[randomPic]
        
            if ((tapRow == row - 1 && tapCol == col) || (tapRow == row && tapCol == col - 1) || (tapRow == row + 1 && tapCol == col) || (tapRow == row && tapCol == col + 1)) {

            // update the step
                if (tapViewIndex != emptyImageIndex) {
                    p.step++
                    playerStep.text = String(p.step)
                }
        
                // exchange, same as move the piece
                var medium = eightPicList[tapViewIndex]
                eightPicList[tapViewIndex] = eightPicList[emptyImageIndex]
                eightPicList[emptyImageIndex] = medium
        
                emptyImageIndex = tapViewIndex
        
                // update
                for (i = 0; i < 9; i++) {
                    if (eightPicList[i] == 8) {
                        eightImageList[emptyImageIndex].image = nil
                    }
                    else {
                        var k = String(eightPicList[i] + 1)
                        var image = UIImage(named: picName + k + ".jpg")
                        eightImageList[i].image = image
                    }
                }
                // check win
                if eightPicList==[0,1,2,3,4,5,6,7,8]{
                    winImageView.image = UIImage(named: "win.jpg")
                    winImageView.center.x = CGFloat(160)
                    winImageView.center.x = CGFloat(260)
                    view.addSubview(winImageView)
                    for (var i = 0; i < 5; i++) {
                        if (p.step <= mode1[i]) {
                            var temp = mode1[i]
                            for (var j = 4; j > i; j--) {
                                mode1[j] = mode1[j - 1]
                            }
                            mode1[i] = p.step
                            break
                        }
                    }
                    isWin = true
                    isPlaying = false
                }
            }
        }
    }
    
}


func shuffle <T> (var list: Array< T >) -> Array< T > {
    for i in 0..<list.count {
        let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
        list.insert(list.removeAtIndex(j), atIndex: i)
    }
    return list
}











