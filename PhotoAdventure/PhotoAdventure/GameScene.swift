//
//  GameScene.swift
//  PhotoAdventure
//
//  Created by James on 12/1/14.
//  Copyright (c) 2014 Bo Ning. All rights reserved.
//

import SpriteKit
class GameScene: SKScene, SKPhysicsContactDelegate{
    
    // game 1 parameters
    var ship1 = SKSpriteNode()
    var oneCoin1 = SKSpriteNode()
    var coinNum1: Int = 8
    var disMove1: CGFloat = 35.0
    var shipAction1=SKAction()
    var textLabel1 = SKLabelNode()
    var isFirstTouch1 = false
    var isGameOver1 = false
    let shipCategory1: UInt32 = 1 << 1
    let coinCategory1: UInt32 = 1 << 2
    // game 2 parameters
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
    // game 3 parameters
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
        if (GameCharactor.gameNum == 1) {
            didMoveToView1()
        }
        if (GameCharactor.gameNum == 2) {
            didMoveToView2()
        }
        if (GameCharactor.gameNum == 3) {
            didMoveToView3()
        }
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if (GameCharactor.gameNum == 1) {
            touchesBegan1(touches, withEvent: event)
        }
        if (GameCharactor.gameNum == 2) {
            touchesBegan2(touches, withEvent: event)
        }
        if (GameCharactor.gameNum == 3) {
            touchesBegan3(touches, withEvent: event)
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        if (GameCharactor.gameNum == 1) {
            update1(currentTime)
        }
        if (GameCharactor.gameNum == 2) {
            update2(currentTime)
        }
        if (GameCharactor.gameNum == 3) {
            update3(currentTime)
        }
    }
    
    
    func didBeginContact(contact: SKPhysicsContact!) {
        if (GameCharactor.gameNum == 1) {
            didBeginContact1(contact)
        }
        if (GameCharactor.gameNum == 2) {
            didBeginContact2(contact)
        }
        if (GameCharactor.gameNum == 3) {
            didBeginContact3(contact)
        }
    }
    
    

    /* helper functions */
    
    func didMoveToView1() {
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
            var x_v1 = Double(rand * 30) * pow(Double(-1), Double(i%2))
            var y_v1 = Double(rand * 35) * pow(Double(-1), Double(i%2))
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
    
    func didMoveToView2() {
        // physics
        self.physicsWorld.gravity = CGVectorMake(0.0, -25.0)
        self.physicsWorld.contactDelegate = self
        
        // background
        var backTexture2 = SKTexture(imageNamed: "background_new.jpg")
        backTexture2.filteringMode = SKTextureFilteringMode.Nearest
        var back2 = SKSpriteNode(texture: backTexture2)
        back2.setScale(1.35)
        back2.position = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5)
        back2.zPosition = -10.0
        self.addChild(back2)
        
        // head
        var headTexture2 = SKTexture(image: GameCharactor.gameCharactor2)
        headTexture2.filteringMode = SKTextureFilteringMode.Nearest
        head2 = SKSpriteNode(texture: headTexture2)
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
        var knifeTexture2 = SKTexture(imageNamed: "knife.png")
        knifeTexture2.filteringMode = SKTextureFilteringMode.Nearest
        knife2 = SKSpriteNode(texture: knifeTexture2)
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
    
    func didMoveToView3() {
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
    
    func touchesBegan1(touches: NSSet, withEvent event: UIEvent) {
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
    
    func touchesBegan2(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if (isFirstTouch2 && noCollision2){
            if (knife2.position.y >= self.frame.size.height * 0.8){
                knife2.physicsBody?.dynamic = false
                self.textLabel2.text = "GAME OVER"
                self.didFinishUpdate()
                return
            }
            else {
                knife2.physicsBody?.dynamic = false
                knife2.speed = 0.0
                self.textLabel2.text = "YOU WIN"
                self.didFinishUpdate()
                return
            }
        }
        
        if (!isFirstTouch2){
            isFirstTouch2 = true
            knife2.runAction(SKAction.sequence([delay2, fall2]))
        }
    }

    func touchesBegan3(touches: NSSet, withEvent event: UIEvent) {
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

    
    
    func update1(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if ship1.position.y>self.frame.size.height {
            ship1.position.y -= self.frame.size.height
            self.disMove1 += 10.0
        }
    }
    
    func update2(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (!noCollision2 && (head2.position.y < -100.0)){
            self.textLabel2.text = "GAME OVER"
            self.didFinishUpdate()
        }
    }
    
    func update3(currentTime: CFTimeInterval) {
        return
    }
    
    
    func didBeginContact1(contact: SKPhysicsContact!) {
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
            self.didFinishUpdate()
        }
    }
    
    func didBeginContact2(contact: SKPhysicsContact!) {
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
    
    func didBeginContact3(contact: SKPhysicsContact!) {
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
                self.didFinishUpdate()
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
                self.didFinishUpdate()
            }
        }
    }

    
}