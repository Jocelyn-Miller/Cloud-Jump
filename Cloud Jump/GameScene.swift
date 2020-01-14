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
    var cloud1 = SKSpriteNode()
    //var rand = Int.random(in: 50..<700)
    var rand = 403
    var positionYVar = 160
    let bottom = SKSpriteNode(color: UIColor.red, size: CGSize(width: 750,           height: 10))
    let cloud = SKSpriteNode(color: UIColor.white, size: CGSize(width: 100,           height: 40))
    var loopCounter = 1
/// add for loop in addclouds
/// make contact between bottom and bird
/// send impulse with bird and cloud
    
    

//player.run(SKAction.applyImpulse(CGVector(dx: 100, dy: 20), duration: 0))
    override func didMove(to view: SKView)
    {
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
        cloud1 = self.childNode(withName: "cloud1") as! SKSpriteNode
        cloud1.texture = SKTexture(imageNamed: "cloud")
        
        //bird is 1 clouds are 2 bottom is 10
     
        self.camera = cam
        cam.setScale(0.5)
        bird.physicsBody?.categoryBitMask = 1
        cloud1.physicsBody?.categoryBitMask = 2
        bird.physicsBody?.contactTestBitMask = 2 | 11
        
        
        //cam.setScale(0.)
        //        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        //        borderBody.friction = 0.0
        //        self.physicsBody = borderBody

       
    }
    
    override func update(_ currentTime: CFTimeInterval)
    { //test to see if bird hits the bottom
       if let accelerometerData = motionManager.accelerometerData
       {
           physicsWorld.gravity.dx = CGFloat(accelerometerData.acceleration.x * 20)
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
            //contact.bodyA.applyImpulse(CGVector(dx: 0, dy: 1000))
            //contact.bodyB.applyImpulse(CGVector(dx: 0, dy: 1000))
        }
        if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 11) ||  (contact.bodyA.categoryBitMask == 11 && contact.bodyB.categoryBitMask == 1)
        {
            print("hit the bottom")
            //contact.bodyA.applyImpulse(CGVector(dx: 0, dy: 1000))
            //contact.bodyB.applyImpulse(CGVector(dx: 0, dy: 1000))
        }
        
        
    }
    func createClouds()
    {
        //cloud.physicsBody = SKPhysicsBody(texture: cloudTexture, size: CGSize(width: 100, height: 40))
        let cloudTexture: SKTexture = SKTexture(imageNamed: "cloud")
        
        //cloud.physicsBody = SKPhysicsBody(texture: cloudTexture, size: CGSize(width: 100, height: 40))
        cloud.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 40))
        cloud.texture = cloudTexture
        cloud.position = CGPoint(x: rand, y: positionYVar)
        cloud.physicsBody?.isDynamic = false
        cloud.physicsBody?.affectedByGravity = false
        cloud.physicsBody?.categoryBitMask = 2
        cloud.physicsBody?.restitution = 1
            cloud.name = "cloud"
            addChild(cloud)
    }
    func addClouds()
    {

        positionYVar+=130
        var randCheck = rand
        rand = Int.random(in: 220...500)
        if rand > randCheck-20 && rand < randCheck + 20
        {
            rand = rand + 70
        }
        createClouds()
        loopCounter+=1
        

    }


    
}
