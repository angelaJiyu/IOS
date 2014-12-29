//
//  GameScene.swift
//  game1
//
//  Created by Jiyu on 11/30/14.
//  Copyright (c) 2014 Jiyu Zhu. All rights reserved.
//

import SpriteKit

class MotorGameScene: SKScene, SKPhysicsContactDelegate {
    
    var stick3 = SKSpriteNode()
    var car3 = SKSpriteNode()
    var target3 = SKSpriteNode()
    var textLabel3 = SKLabelNode()
    var stickLabel3 = SKLabelNode()
    var stickNum3 : Int = 9
    var isFirstTouch3:Bool = false
    var isGameOver3:Bool = false
    var isWin3: Bool = false
    
    let stickCategory3: UInt32 = 1 << 0
    let carCategory3: UInt32 = 1 << 1
    let targetCategory3: UInt32 = 1<<2
    let groundCategory3: UInt32 = 1<<3
    
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0)
        self.physicsWorld.contactDelegate = self
        
        // background 
        var roadTexture3 = SKTexture(imageNamed: "road.jpg")
        roadTexture3.filteringMode = SKTextureFilteringMode.Nearest
        var space3 = SKSpriteNode(texture: roadTexture3)
        space3.setScale(1.2)
        space3.position=CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
        space3.zPosition = -10.0
        self.addChild(space3)
        
        // target 
        let targetTextrue3 = SKTexture(imageNamed: "head_d.png")
        targetTextrue3.filteringMode=SKTextureFilteringMode.Nearest
        self.target3 = SKSpriteNode(texture: targetTextrue3)
        self.target3.setScale(0.3)
        self.target3.position = CGPoint(x: self.frame.size.width*0.33, y: self.frame.size.height*0.93)
        self.target3.zPosition=1.0
        self.target3.physicsBody = SKPhysicsBody(circleOfRadius: self.target3.size.width*0.5)
        self.target3.physicsBody?.dynamic=false
        self.target3.physicsBody?.allowsRotation=false
        self.target3.physicsBody?.categoryBitMask=self.targetCategory3
        self.target3.physicsBody?.contactTestBitMask=self.carCategory3
        self.addChild(self.target3)
        
        
        // car
        let carTextrue3 = SKTexture(image: GameCharactor.gameCharactor3)
        carTextrue3.filteringMode=SKTextureFilteringMode.Nearest
        self.car3 = SKSpriteNode(texture: carTextrue3)
        self.car3.setScale(1.0)
        self.car3.position = CGPoint(x: self.frame.size.width*0.65, y: self.frame.size.height*0.1)
        self.car3.zPosition=1.0
        self.car3.physicsBody = SKPhysicsBody(circleOfRadius: self.car3.size.width*0.5)
        self.car3.physicsBody?.dynamic=false
        self.car3.physicsBody?.allowsRotation=false
        self.car3.physicsBody?.restitution=0.2
        self.car3.physicsBody?.friction=0.2
        self.car3.physicsBody?.categoryBitMask=self.carCategory3
        self.addChild(self.car3)
        
        // create boundary sprite nodes so that the ball can bounce off of the walls
        // var screenRect: CGRect = self.frame
        // create boundary sprite nodes so that the ball can bounce off of the walls
        
        
        var left3 = self.frame.size.width/2.0 - 160.0
        var right3 = self.frame.size.width/2.0 + 160.0
        
        var screenRect3: CGRect = self.frame
        var wallSize3: CGSize = CGSizeMake(1, CGRectGetHeight(screenRect3))
        var ceilingSize3: CGSize = CGSizeMake(CGRectGetWidth(screenRect3), 1)
        
        var leftBoundary3: SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: wallSize3)
        leftBoundary3.physicsBody = SKPhysicsBody(rectangleOfSize: leftBoundary3.size)
        leftBoundary3.position = CGPointMake(left3-60.0, CGRectGetMidY(screenRect3))
        leftBoundary3.physicsBody?.dynamic = false
        leftBoundary3.physicsBody?.restitution = 1.0
        
        var rightBoundary3: SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: wallSize3)
        rightBoundary3.physicsBody = SKPhysicsBody(rectangleOfSize: rightBoundary3.size)
        rightBoundary3.position = CGPointMake(right3+60.0, CGRectGetMidY(screenRect3))
        rightBoundary3.physicsBody?.dynamic = false
        rightBoundary3.physicsBody?.restitution=1.0
        
        var ceilingBoundary3: SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: ceilingSize3)
        ceilingBoundary3.physicsBody = SKPhysicsBody(rectangleOfSize: ceilingBoundary3.size)
        ceilingBoundary3.position = CGPointMake(CGRectGetMidX(screenRect3),
            CGRectGetMaxY(screenRect3))
        ceilingBoundary3.physicsBody?.dynamic = false
        ceilingBoundary3.physicsBody?.restitution = 1.0
        
        var groundBoundary3:SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: ceilingSize3)
        groundBoundary3.physicsBody = SKPhysicsBody(rectangleOfSize: groundBoundary3.size)
        groundBoundary3.position = CGPointMake(CGRectGetMidX(screenRect3), CGRectGetMinY(screenRect3))
        groundBoundary3.physicsBody?.dynamic = false
        groundBoundary3.physicsBody?.restitution = 1.0
        groundBoundary3.physicsBody?.categoryBitMask = self.groundCategory3
        groundBoundary3.physicsBody?.contactTestBitMask = self.carCategory3
        
        // add boundary sprites to scene
        self.addChild(leftBoundary3)
        self.addChild(rightBoundary3)
        self.addChild(ceilingBoundary3)
        self.addChild(groundBoundary3)
        
        
        // label
        self.textLabel3 = SKLabelNode(fontNamed: "HelveticaNeue-Font")
        self.textLabel3.fontSize = 50.0
        self.textLabel3.fontColor = SKColor.redColor()
        self.textLabel3.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)
        self.textLabel3.zPosition = 5.0
        self.addChild(textLabel3)
        
        self.stickLabel3 = SKLabelNode(fontNamed: "HelveticaNeue-Font")
        self.stickLabel3.fontSize = 25.0
        self.stickLabel3.fontColor = SKColor.blackColor()
        self.stickLabel3.position = CGPointMake(self.frame.size.width*0.6, self.frame.size.height*0.92)
        self.stickLabel3.zPosition = 5.0
        self.stickLabel3.text = "Sticks Num: \(self.stickNum3)"
        self.addChild(stickLabel3)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if (isFirstTouch3 && self.stickNum3 > 0 && !isWin3 && !isGameOver3) {
            for touch: AnyObject in touches {
                self.stickNum3--;
                self.stickLabel3.text = "Sticks Num: \(self.stickNum3)"
                let location3 = touch.locationInNode(self)
            
                self.stick3 = SKSpriteNode(imageNamed:"stick.jpg")
                self.stick3.setScale(0.5)
                self.stick3.position = location3
                self.stick3.physicsBody = SKPhysicsBody(rectangleOfSize: self.stick3.size)
                self.stick3.physicsBody?.dynamic=false
                self.stick3.physicsBody?.allowsRotation=true
                self.stick3.physicsBody?.affectedByGravity=false
                self.stick3.physicsBody?.categoryBitMask = self.stickCategory3
                self.stick3.physicsBody?.contactTestBitMask = self.carCategory3
            
                let action3 = SKAction.rotateByAngle(CGFloat(M_PI), duration:2.0)
                
                stick3.runAction(SKAction.repeatActionForever(action3))
                self.addChild(stick3)
            }
        }
        
        if (!isFirstTouch3){
            isFirstTouch3 = true
            self.car3.physicsBody.dynamic = true
            self.car3.physicsBody?.velocity = CGVectorMake(-350.0, 600.0)
            self.car3.physicsBody?.affectedByGravity = true
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    func didBeginContact(contact: SKPhysicsContact!) {
        
        if isFirstTouch3 {
            var firstBody1: SKPhysicsBody
            var secondBody1: SKPhysicsBody
        
            // collision between target and car: 1:target 2:car
            // collision between stick and car: 1:car 2: stick
            // collision between car and ground: 1:ground 2: car
            if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
                firstBody1 = contact.bodyB
                secondBody1 = contact.bodyA
            }
            else {
                firstBody1 = contact.bodyA
                secondBody1 = contact.bodyB
            }
        
            if (firstBody1.categoryBitMask & groundCategory3) != 0 && (secondBody1.categoryBitMask & carCategory3) != 0 {
                self.car3.speed = 0.0
                self.target3.speed = 0.0
                self.car3.physicsBody?.dynamic=false
                self.car3.physicsBody?.dynamic=false
                self.isGameOver3=true
                self.textLabel3.text = "GAME OVER"
            }
        
            if (firstBody1.categoryBitMask & carCategory3) != 0 && (secondBody1.categoryBitMask & stickCategory3) != 0 {
                self.car3.physicsBody?.applyImpulse(CGVectorMake(-40.0, 85.0))
            
            }
            if (firstBody1.categoryBitMask & targetCategory3) != 0 && (secondBody1.categoryBitMask & carCategory3) != 0{
            
                firstBody1.node.removeFromParent()
                self.car3.physicsBody?.dynamic=false
                self.car3.speed = 0.0
                self.target3.speed = 0.0
                self.isWin3=true
                self.textLabel3.text = "YOU WIN"
            }
        }
        
    }
    

    
}
