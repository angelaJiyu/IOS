//
//  GameSelectViewController.swift
//  PhotoAdventure
//
//  Created by James on 11/29/14.
//  Copyright (c) 2014 Bo Ning. All rights reserved.
//

import UIKit

class GameMenuViewController: UIViewController {
    
    var baseImage: UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameCharactor.gameCharactor1 = UIImage()
        GameCharactor.gameCharactor2 = UIImage()
        GameCharactor.gameCharactor3 = UIImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func spButton(sender: AnyObject) {
        GameCharactor.gameNum = 1
        if (GameCharactor.hasPhoto == false) {
            baseImage = UIImage(named: "ufo_d.png")
        } else {
            if (GameCharactor.gameCharGender == 1) {
                baseImage = UIImage(named: "ufo_m.png")
            } else {
                baseImage = UIImage(named: "ufo_f.png")
            }
        }
        var faceSize = CGSizeMake(200, 276)
        var faceOrigin = CGPointMake(90, 30)
        mergeFace(faceSize, faceOrigin: faceOrigin)
        var testView = UIImageView(frame: CGRectMake(0, 0, 150, 150))
        testView.image = GameCharactor.gameCharactor1
        self.view.addSubview(testView)
        println("space view!")
    }
    

    @IBAction func cutButton(sender: AnyObject) {
        GameCharactor.gameNum = 2
        if (GameCharactor.hasPhoto == false) {
            baseImage = UIImage(named: "head_d.png")
        } else {
            if (GameCharactor.gameCharGender == 1) {
                baseImage = UIImage(named: "head_m.png")
            } else {
                baseImage = UIImage(named: "head_f.png")
            }
        }
        var faceSize = CGSizeMake(131, 170)
        var faceOrigin = CGPointMake(32, 4)
        mergeFace(faceSize, faceOrigin: faceOrigin)
        var testView = UIImageView(frame: CGRectMake(0, 150, 150, 150))
        testView.image = GameCharactor.gameCharactor2
        self.view.addSubview(testView)
        println("cut view")
        
    }
    
    @IBAction func motorButton(sender: AnyObject) {
        GameCharactor.gameNum = 3
        if (GameCharactor.hasPhoto == false) {
            baseImage = UIImage(named: "moto_d.png")
        } else {
            if (GameCharactor.gameCharGender == 1) {
                baseImage = UIImage(named: "moto_m.png")
            } else {
                baseImage = UIImage(named: "moto_f.png")
            }
        }
        var faceSize = CGSizeMake(200, 260)
        var faceOrigin = CGPointMake(45, 23)
        mergeFace(faceSize, faceOrigin: faceOrigin)
        var testView = UIImageView(frame: CGRectMake(0, 300, 150, 150))
        testView.image = GameCharactor.gameCharactor3
        self.view.addSubview(testView)
        println("motor view")
        
    }
    
    func mergeFace(faceSize: CGSize, faceOrigin: CGPoint) {
        var baseScale = 100.0 / baseImage.size.height
        var baseSize = CGSizeMake(baseScale * baseImage.size.width, 100)
        if (GameCharactor.hasPhoto == false) {
            UIGraphicsBeginImageContextWithOptions(baseSize, false, 0.0)
            baseImage.drawInRect(CGRectMake(0, 0, baseSize.width, baseSize.height))
            if (GameCharactor.gameNum == 1) {
                GameCharactor.gameCharactor1 = UIGraphicsGetImageFromCurrentImageContext()
            }
            if (GameCharactor.gameNum == 2) {
                GameCharactor.gameCharactor2 = UIGraphicsGetImageFromCurrentImageContext()
            }
            if (GameCharactor.gameNum == 3) {
                GameCharactor.gameCharactor3 = UIGraphicsGetImageFromCurrentImageContext()
            }
            UIGraphicsEndImageContext()
            return
        }
        var scaledFaceSize = CGSizeMake(faceSize.width * baseScale, faceSize.height * baseScale)
        var scaledFaceOrigin = CGPointMake(faceOrigin.x * baseScale, faceOrigin.y * baseScale)
        var eyeImageWidth = 0.4 * scaledFaceSize.width * 0.9
        var compScale = eyeImageWidth / GameCharactor.leftEyeImage.size.width
        var scaledEyeSize = CGSizeMake(compScale * GameCharactor.leftEyeImage.size.width, compScale * GameCharactor.leftEyeImage.size.height)
        var scaledMouthSize = CGSizeMake(compScale * GameCharactor.mouthImage.size.width, compScale * GameCharactor.mouthImage.size.height)
        var scaledEyeOrigin = CGPointMake(scaledFaceOrigin.x + scaledFaceSize.width / 2.0 - scaledEyeSize.width, scaledFaceOrigin.y + 0.35 * scaledFaceSize.height)
        var scaledMouthOrigin = CGPointMake(scaledEyeOrigin.x + scaledEyeSize.width - scaledMouthSize.width / 2.0 - 1.5, scaledEyeOrigin.y + scaledEyeSize.height)
        UIGraphicsBeginImageContextWithOptions(baseSize, false, 0.0)
        baseImage.drawInRect(CGRectMake(0, 0, baseSize.width, baseSize.height))
        GameCharactor.leftEyeImage.drawInRect(CGRectMake(scaledEyeOrigin.x, scaledEyeOrigin.y, scaledEyeSize.width, scaledEyeSize.height))
        
        GameCharactor.rightEyeImage.drawInRect(CGRectMake(scaledEyeOrigin.x + scaledEyeSize.width, scaledEyeOrigin.y, scaledEyeSize.width, scaledEyeSize.height))
        GameCharactor.mouthImage.drawInRect(CGRectMake(scaledMouthOrigin.x, scaledMouthOrigin.y, scaledMouthSize.width, scaledMouthSize.height))
        if (GameCharactor.gameNum == 1) {
            GameCharactor.gameCharactor1 = UIGraphicsGetImageFromCurrentImageContext()
        }
        if (GameCharactor.gameNum == 2) {
            GameCharactor.gameCharactor2 = UIGraphicsGetImageFromCurrentImageContext()
        }
        if (GameCharactor.gameNum == 3) {
            GameCharactor.gameCharactor3 = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        println("face merged!")
    }
    
}