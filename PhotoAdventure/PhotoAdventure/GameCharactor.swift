//
//  GameCharactor.swift
//  PhotoAdventure
//
//  Created by James on 11/30/14.
//  Copyright (c) 2014 Bo Ning. All rights reserved.
//

import UIKit
import SpriteKit

struct GameCharactor {
    static var gameCharactor1: UIImage = UIImage()
    static var gameCharactor2: UIImage = UIImage()
    static var gameCharactor3: UIImage = UIImage()
    static var gameCharGender: Int = Int(0)
    static var leftEyeImage: UIImage = UIImage()
    static var rightEyeImage: UIImage = UIImage()
    static var mouthImage: UIImage = UIImage()
    static var hasPhoto: Bool = false
    static var gameNum = -1
    static var gameScene = SKScene()
    static var gameView = SKView()
}