//
//  GameScene.swift
//  Cloud Jump
//
//  Created by  on 1/2/20.
//  Copyright © 2020 goodstuff. All rights reserved.
//
import CoreMotion
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var bird = SKSpriteNode()
    let cam = SKCameraNode()
    var motionManager: CMMotionManager!
    
    //var rand = Int.random(in: 50..<700)
    var rand = 403
    var positionYVar = 160
    let bottom = SKSpriteNode(color: UIColor.red, size: CGSize(width: 750,           height: 10))
    let cloudTexture: SKTexture = SKTexture(imageNamed: "cloud")
    
    var bounceCounter = 0
    var cloudCollection: [SKSpriteNode] = []
    var bottomHitBool = false
    //var emptyDoubles: [Double] = []
    ///add nest
    ///add stop functions from  breakout
    /// add emittor
    /// deactivate clouds after certain heights
    ///make sk action that is impulse 
    
    

//player.run(SKAction.applyImpulse(CGVector(dx: 100, dy: 20), duration: 0))
    override func didMove(to view: SKView)
    {
        
        let cloud1 = SKSpriteNode(color: UIColor.white, size: CGSize(width: 100,           height: 40))
        //cloud.physicsBody = SKPhysicsBody(texture: cloudTexture, size: CGSize(width: 100, height: 40))
        cloud1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 40))
        cloud1.texture = cloudTexture
        cloud1.position = CGPoint(x: 300, y: positionYVar)
        cloud1.physicsBody?.isDynamic = false
        cloud1.physicsBody?.affectedByGravity = false
        cloud1.physicsBody?.categoryBitMask = 3
        cloud1.physicsBody?.restitution = 1
        
            //cloud.name = "cloud"
            addChild(cloud1)
        addClouds()
        let groundTexture: SKTexture = SKTexture(imageNamed: "ground")
        bottom.physicsBody = SKPhysicsBody(texture: groundTexture, size: CGSize(width: 750, height: 10))
        bottom.texture = groundTexture
        bottom.position = CGPoint(x: frame.width / 2, y: 70)
        bottom.physicsBody?.isDynamic = false
        //bottom.color = UIColor.red
        bottom.physicsBody?.affectedByGravity = false
        bottom.physicsBody?.categoryBitMask = 11
        bottom.name = "bottom"
        //makeBottomGround()
                addChild(bottom)
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        physicsWorld.contactDelegate = self

        bird = self.childNode(withName: "bird") as! SKSpriteNode
        bird.texture = SKTexture(imageNamed: "bird")
//        cloud1 = self.childNode(withName: "cloud1") as! SKSpriteNode
//        cloud1.texture = SKTexture(imageNamed: "cloud")
        
        //bird is 1 clouds are 2 bottom is 10
     
        self.camera = cam
        cam.setScale(0.5)
        bird.physicsBody?.categoryBitMask = 1
        //cloud1.physicsBody?.categoryBitMask = 7
        bird.physicsBody?.contactTestBitMask = 2 | 11
        
        
        //cam.setScale(0.)
        //        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        //        borderBody.friction = 0.0
        //        self.physicsBody = borderBody

       
    }
    
    override func update(_ currentTime: CFTimeInterval)
    { //test to see if bird hits the bottom
        
        ///LETS BIRD ONLY HIT ON THE DOWN BOUNCE
        
        if ((bird.physicsBody?.velocity.dy)!) > CGFloat(0)
            {
                //bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -400))
                for cloud in cloudCollection
                {
                cloud.physicsBody = nil
                }
            }
            else
            {
                for cloud in cloudCollection
                {
                    cloud.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 40))
                    cloud.texture = cloudTexture
                    cloud.physicsBody?.isDynamic = false
                    cloud.physicsBody?.affectedByGravity = false
                    cloud.physicsBody?.categoryBitMask = 2
                    cloud.physicsBody?.restitution = 1.2
                }
                    
            }
        if bottomHitBool == false
        {
            if let accelerometerData = motionManager.accelerometerData
            {
           physicsWorld.gravity.dx = CGFloat(accelerometerData.acceleration.x * 20)
            }
        }
        
        if bird.position.x > frame.width
        {
            bird.position.x = 0
        }
        if bird.position.x < 0
        {
            bird.position.x = frame.width
        }
        
        let positiony = bird.position.y
        if positiony < 400
        {
            cam.position.y = 400
            cam.position.x = frame.width / 2
        }
        else{
        cam.position.x = frame.width/2
        cam.position.y = bird.position.y
        }
    }
    func didBegin(_ contact: SKPhysicsContact)
    {
        //accelerate on clouds
        //stop on bottom
        if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2) ||  (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1)
        {
            print("hit the cloud")
//            if bounceCounter <= 1 {
//            bird.physicsBody?.velocity.dy = (bird.physicsBody?.velocity.dy)! + 400
//                bounceCounter += 1
            //}else
            //            {
            //                bird.physicsBody?.velocity.dy = (bird.physicsBody?.velocity.dy)! + 200
            //            }
                        
            if contact.bodyA.categoryBitMask == 1
            {
                contact.bodyA.applyImpulse(CGVector(dx: 0, dy: contact.bodyA.velocity.dy + 500))
            }
            else
            {
                contact.bodyB.applyImpulse(CGVector(dx: 0, dy:contact.bodyB.velocity.dy + 500))
            }
                
//
            //contact.bodyA.applyForce(CGVector(dx: 0, dy: 500))
        }
        if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 11) ||  (contact.bodyA.categoryBitMask == 11 && contact.bodyB.categoryBitMask == 1)
        {
            print("hit the bottom")
            //ADD STOP FUNCTIONS
            resetBird()
            //motionManager = nil
        }
        
        
    }
    func createClouds()
    {
        //cloud.physicsBody = SKPhysicsBody(texture: cloudTexture, size: CGSize(width: 100, height: 40))
        //let cloudTexture: SKTexture = SKTexture(imageNamed: "cloud")
        let cloud = SKSpriteNode(color: UIColor.white, size: CGSize(width: 100,           height: 40))
        //cloud.physicsBody = SKPhysicsBody(texture: cloudTexture, size: CGSize(width: 100, height: 40))
        cloud.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 40))
        cloud.texture = cloudTexture
        cloud.position = CGPoint(x: rand, y: positionYVar)
        cloud.physicsBody?.isDynamic = false
        cloud.physicsBody?.affectedByGravity = false
        cloud.physicsBody?.categoryBitMask = 2
        cloud.physicsBody?.restitution = 1.2
            //cloud.name = "cloud"
            addChild(cloud)
        cloudCollection.append(cloud)
    }
    func addClouds()
    {
        for col in 0...12
        {
        positionYVar+=110
            
        var randCheck = rand
        rand = Int.random(in: 240...520)
            while rand >= (randCheck - 50) && rand <= (randCheck+50)
            {
                rand = Int.random(in: 240...520)
            }
        createClouds()
           
        }

    }
    
    func bringBirdToCenter()
    {
        bird.position = CGPoint(x: 350, y: 70)
    }
    func resetBird()
       {
           print("reset bird called")
        bottomHitBool = true
           bird.physicsBody?.velocity = CGVector.zero
        bird.removeFromParent()

           let wait = SKAction.wait(forDuration: 0.5)
           let repositionBird = SKAction.run(bringBirdToCenter)

           let sequence = SKAction.sequence([wait, repositionBird])
           run(sequence)
       }

       


       
//    let spark =  SKEmitterNode(fileNamed: "spark.sks")
//               spark?.position = contact.contactPoint
//               spark?.targetNode = self
//               addChild(spark!)
}
