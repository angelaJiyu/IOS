//
//  GameScene.swift
//  game2
//
//  Created by Jiyu on 11/30/14.
//  Copyright (c) 2014 Jiyu Zhu. All rights reserved.
//

import SpriteKit

class SpaceGameScene: SKScene, SKPhysicsContactDelegate{
    
    var ship1 = SKSpriteNode()
    var oneCoin1 = SKSpriteNode()
    var coinNum1: Int = 8
    var disMove1: CGFloat = 25.0
    var shipAction1=SKAction()
    var textLabel1 = SKLabelNode()
    var isFirstTouch1 = false
    var isGameOver1 = false
    
    
    let shipCategory1: UInt32 = 1 << 1
    let coinCategory1: UInt32 = 1 << 2
    
    
    override func didMoveToView(view: SKView) {
        // physics
        self.physicsWorld.gravity = CGVectorMake(0.0, -1.0)
        self.physicsWorld.contactDelegate = self
        // space--background
        var roadTexture1 = SKTexture(imageNamed: "space.jpg")
        roadTexture1.filteringMode = SKTextureFilteringMode.Nearest
        var space1 = SKSpriteNode(texture: roadTexture1)
        space1.setScale(1.5)
        space1.position=CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
        space1.zPosition = -10.0
        self.addChild(space1)
        //coins
        let coinTexture1 = SKTexture(imageNamed: "head_d.png")
        coinTexture1.filteringMode = SKTextureFilteringMode.Nearest
        
        var left1 = self.frame.size.width/2.0 - 160.0
        var right1 = self.frame.size.width/2.0 + 160.0
        
        var i:Int
        for (i = 1; i<=coinNum1; i++){
            var rand = arc4random_uniform(UInt32(coinNum1))
            oneCoin1 = SKSpriteNode(texture: coinTexture1)
            oneCoin1.setScale(0.25)
            // positions
            var x1 = left1 + oneCoin1.size.width * CGFloat(rand)
            var y1: CGFloat
            if (i%3 == 0) {
                y1 = self.frame.size.height * 0.85
            }
            else if (i%3 == 1){
                y1 = self.frame.size.height * 0.65

            }
            else{
                y1 = self.frame.size.height * 0.45
            }
            // velocities
            var x_v1 = Double(rand * 40) * pow(Double(-1), Double(i%2))
            var y_v1 = Double(rand * 45) * pow(Double(-1), Double(i%2))
            oneCoin1.position=CGPointMake(x1, y1)
            oneCoin1.physicsBody = SKPhysicsBody (rectangleOfSize: oneCoin1.size)
            oneCoin1.physicsBody?.dynamic = true
            oneCoin1.physicsBody?.velocity = CGVectorMake(CGFloat(x_v1), CGFloat(y_v1))
            oneCoin1.physicsBody?.categoryBitMask = self.coinCategory1
            oneCoin1.physicsBody?.affectedByGravity = false
            oneCoin1.physicsBody?.restitution = 1.0
            oneCoin1.physicsBody?.friction = 0.0
            oneCoin1.physicsBody?.linearDamping = 0.0
            oneCoin1.physicsBody?.angularDamping = 0.0
            self.addChild(oneCoin1)
            // label
            self.textLabel1 = SKLabelNode(fontNamed: "HelveticaNeue-Font")
            self.textLabel1.fontSize = 50.0
            self.textLabel1.fontColor = SKColor.redColor()
            self.textLabel1.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)
            self.textLabel1.zPosition = 5.0
            self.addChild(textLabel1)
        }
        // spaceship
        var shipTexture1 = SKTexture(image: GameCharactor.gameCharactor1)
        shipTexture1.filteringMode = SKTextureFilteringMode.Nearest
        self.ship1 = SKSpriteNode(texture: shipTexture1)
        self.ship1.setScale(1.0)
        let moveShip1 = SKAction.moveBy(CGVectorMake(0.0, disMove1), duration: 0.5)
        shipAction1 = SKAction.repeatActionForever(moveShip1)
        self.ship1.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.15)
        self.ship1.physicsBody=SKPhysicsBody(circleOfRadius: ship1.size.height/2.0)
        self.ship1.physicsBody?.dynamic = false
        self.ship1.physicsBody?.categoryBitMask = self.shipCategory1
        self.ship1.physicsBody?.collisionBitMask = self.coinCategory1
        self.ship1.physicsBody?.contactTestBitMask = self.coinCategory1
        self.ship1.physicsBody?.affectedByGravity = false
        self.addChild(self.ship1)
        // create boundary sprite nodes so that the ball can bounce off of the walls
        //var screenRect: CGRect = self.frame
        // create boundary sprite nodes so that the ball can bounce off of the walls
        var screenRect1: CGRect = self.frame
        var wallSize1: CGSize = CGSizeMake(1, CGRectGetHeight(screenRect1))
        var ceilingSize1: CGSize = CGSizeMake(CGRectGetWidth(screenRect1), 1)
        var leftBoundary1: SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: wallSize1)
        leftBoundary1.physicsBody = SKPhysicsBody(rectangleOfSize: leftBoundary1.size)
        leftBoundary1.position = CGPointMake(left1-60.0, CGRectGetMidY(screenRect1))
        leftBoundary1.physicsBody?.dynamic = false
        leftBoundary1.physicsBody?.restitution = 1.0
        var rightBoundary1: SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: wallSize1)
        rightBoundary1.physicsBody = SKPhysicsBody(rectangleOfSize: rightBoundary1.size)
        rightBoundary1.position = CGPointMake(right1+60.0, CGRectGetMidY(screenRect1))
        rightBoundary1.physicsBody?.dynamic = false
        rightBoundary1.physicsBody?.restitution=1.0
        
        var ceilingBoundary1: SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: ceilingSize1)
        ceilingBoundary1.physicsBody = SKPhysicsBody(rectangleOfSize: ceilingBoundary1.size)
        ceilingBoundary1.position = CGPointMake(CGRectGetMidX(screenRect1),
            CGRectGetMaxY(screenRect1))
        ceilingBoundary1.physicsBody?.dynamic = false
        ceilingBoundary1.physicsBody?.restitution = 1.0
        
        var groundBoundary1:SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: ceilingSize1)
        groundBoundary1.physicsBody = SKPhysicsBody(rectangleOfSize: groundBoundary1.size)
        groundBoundary1.position = CGPointMake(CGRectGetMidX(screenRect1), CGRectGetMinY(screenRect1))
        groundBoundary1.physicsBody?.dynamic = false
        groundBoundary1.physicsBody?.restitution = 1.0
        
        // add boundary sprites to scene
        self.addChild(leftBoundary1)
        self.addChild(rightBoundary1)
        self.addChild(ceilingBoundary1)
        self.addChild(groundBoundary1)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if (!isFirstTouch1){
            isFirstTouch1 = true
            self.ship1.runAction(shipAction1)
        }
        
        var leftBoundary1 = self.frame.size.width/2.0 - 160.0
        var rightBoundary1 = self.frame.size.width/2.0 + 160.0
        
        for touch: AnyObject in touches {
            
            var point1 = touch.locationInNode(self)
            
            if (isFirstTouch1 && (!isGameOver1)) {
                if (point1.x < self.frame.size.width/2.0){
                    if ((ship1.position.x - 0.1 * ship1.size.width/2.0)>leftBoundary1) {
                        ship1.position.x -= 30.0
                    }
                }
                else {
                    if ((ship1.position.x + 0.1 * ship1.size.width/2.0)<rightBoundary1) {
                        ship1.position.x += 30.0
                    }
                }
            }
        }
    }
   
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if ship1.position.y>self.frame.size.height {
            ship1.position.y -= self.frame.size.height
            self.disMove1 += 10.0
        }
        
    }
    
    func didBeginContact(contact: SKPhysicsContact!) {
       
        var firstBody1: SKPhysicsBody
        var secondBody1: SKPhysicsBody
        
        // firstbody is coin, second is ship
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
            firstBody1 = contact.bodyB
            secondBody1 = contact.bodyA
        }
        else {
            firstBody1 = contact.bodyA
            secondBody1 = contact.bodyB
        }
        if((firstBody1.categoryBitMask & coinCategory1) != 0 && (secondBody1.categoryBitMask &  shipCategory1) != 0) {
            self.textLabel1.text = "GAME OVER"
            self.ship1.speed = 0.0
            self.isGameOver1 = true
        }

    }
    

    
}
