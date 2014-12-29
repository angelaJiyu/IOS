//
//  GameViewController.swift
//  game2
//
//  Created by Jiyu on 11/30/14.
//  Copyright (c) 2014 Jiyu Zhu. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }

}

class GameViewController: UIViewController {

    // var scene: SKScene = SKScene()

    @IBAction func backButton(sender: AnyObject) {
        GameCharactor.gameView = SKView()
        self.view = GameCharactor.gameView
        GameCharactor.gameCharactor1 = UIImage()
        GameCharactor.gameCharactor2 = UIImage()
        GameCharactor.gameCharactor3 = UIImage()
        GameCharactor.gameScene.removeFromParent()
        GameCharactor.gameView.presentScene(nil)
        GameCharactor.gameScene.paused = true
        GameCharactor.gameScene.didFinishUpdate()
        println("skview clear")
    }

    @IBAction func goButton(sender: AnyObject) {
        self.viewDidLoad()
        GameCharactor.gameView = SKView()
        GameCharactor.gameScene.removeFromParent()
        GameCharactor.gameScene = GameScene.unarchiveFromFile("GameScene") as GameScene

        // Configure the view.
        GameCharactor.gameView = self.view as SKView
        GameCharactor.gameView.showsFPS = true
        GameCharactor.gameView.showsNodeCount = true
                
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        GameCharactor.gameView.ignoresSiblingOrder = true
            
        /* Set the scale mode to scale to fit the window */
        GameCharactor.gameScene.scaleMode = .AspectFill
        GameCharactor.gameView.presentScene(GameCharactor.gameScene)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
