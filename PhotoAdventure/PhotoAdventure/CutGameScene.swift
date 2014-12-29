//
//  GameScene.swift
//  game3
//
//  Created by Jiyu on 11/30/14.
//  Copyright (c) 2014 Jiyu Zhu. All rights reserved.
//


import SpriteKit

class CutGameScene: SKScene, SKPhysicsContactDelegate{
    
    var textLabel2=SKLabelNode()
    var head2=SKSpriteNode()
    var knife2=SKSpriteNode()
    var action2=SKAction()
    var delay2=SKAction()
    var fall2=SKAction()
    
    var time2 = 0
    
    var isFirstTouch2 = false
    var noCollision2 = true
    let headCategory2: UInt32 = 1 << 0
    let knifeCategory2: UInt32 = 1 << 1
    
    
    override func didMoveToView(view: SKView) {
        // physics
        self.physicsWorld.gravity = CGVectorMake(0.0, -25.0)
        self.physicsWorld.contactDelegate = self
        
        // background
        var backTexture = SKTexture(imageNamed: "background_new.jpg")
        backTexture.filteringMode = SKTextureFilteringMode.Nearest
        var back2 = SKSpriteNode(texture: backTexture)
        back2.setScale(1.35)
        back2.position = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5)
        back2.zPosition = -10.0
        self.addChild(back2)
        
        // head
        var headTexture = SKTexture(image: GameCharactor.gameCharactor2)
        headTexture.filteringMode = SKTextureFilteringMode.Nearest
        head2 = SKSpriteNode(texture: headTexture)
        head2.setScale(1.5)
        head2.position = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.25)
        head2.physicsBody = SKPhysicsBody(circleOfRadius: head2.size.width/2.0)
        head2.physicsBody?.dynamic = true
        head2.physicsBody?.allowsRotation = false
        head2.physicsBody?.affectedByGravity = false
        head2.physicsBody?.categoryBitMask = self.headCategory2
        head2.physicsBody?.collisionBitMask = self.knifeCategory2
        head2.physicsBody?.contactTestBitMask = self.knifeCategory2
        self.addChild(head2)
        
        // knife
        var knifeTexture = SKTexture(imageNamed: "knife.png")
        knifeTexture.filteringMode = SKTextureFilteringMode.Nearest
        knife2 = SKSpriteNode(texture: knifeTexture)
        knife2.setScale(1.0)
        knife2.position = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.85)
        knife2.physicsBody = SKPhysicsBody(circleOfRadius: knife2.size.width/2.0)
        knife2.physicsBody?.dynamic = true
        knife2.physicsBody?.allowsRotation = true
        knife2.physicsBody?.affectedByGravity = false
        knife2.physicsBody?.categoryBitMask = knifeCategory2
        action2 = SKAction.rotateByAngle(CGFloat(2.0 * M_PI), duration: 0.5)
        knife2.runAction(SKAction.repeatActionForever(action2))
        
        var randTime = arc4random_uniform(UInt32(4.0) + 1.0)
        delay2 = SKAction.waitForDuration(NSTimeInterval(randTime))
        fall2 = SKAction.moveBy(CGVectorMake(0.0, -1000.0), duration: 1.2)
        
        self.addChild(knife2)
        
        
        // label
        self.textLabel2 = SKLabelNode(fontNamed: "HelveticaNeue-Font")
        self.textLabel2.fontSize = 50.0
        self.textLabel2.fontColor = SKColor.redColor()
        self.textLabel2.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)
        self.textLabel2.zPosition = 5.0
        self.addChild(textLabel2)
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if (isFirstTouch2 && noCollision2){
            if (knife2.position.y >= self.frame.size.height * 0.8){
                knife2.physicsBody?.dynamic = false
                self.textLabel2.text = "GAME OVER"
                return
            }
            else {
                knife2.physicsBody?.dynamic = false
                knife2.speed = 0.0
                self.textLabel2.text = "YOU WIN"
                return
            }
        }
        
        if (!isFirstTouch2){
            isFirstTouch2 = true
            knife2.runAction(SKAction.sequence([delay2, fall2]))
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (!noCollision2 && (head2.position.y < -100.0)){
            self.textLabel2.text = "GAME OVER"
        }
    }
    
    
    func didBeginContact(contact: SKPhysicsContact!) {
        var firstBody1: SKPhysicsBody
        var secondBody1: SKPhysicsBody
        
        // firstbody is knife, secondbody is head
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
            firstBody1 = contact.bodyB
            secondBody1 = contact.bodyA
        }
        else {
            firstBody1 = contact.bodyA
            secondBody1 = contact.bodyB
        }
        
        if((firstBody1.categoryBitMask & knifeCategory2) != 0 && (secondBody1.categoryBitMask & headCategory2) != 0) {
            noCollision2 = false
        }
    }
    
    
}
