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

//player.run(SKAction.applyImpulse(CGVector(dx: 100, dy: 20), duration: 0))
    override func didMove(to view: SKView)
    {
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        physicsWorld.contactDelegate = self

        bird = self.childNode(withName: "bird") as! SKSpriteNode
        bird.texture = SKTexture(imageNamed: "bird")
        cloud1 = self.childNode(withName: "cloud1") as! SKSpriteNode
        cloud1.texture = SKTexture(imageNamed: "cloud")
        cloud1.physicsBody?.categoryBitMask = 2
        bird.physicsBody?.contactTestBitMask = 2 | 10
        //bird is 1 clouds are 2 bottom is 10
        
        self.camera = cam
        cam.setScale(1)
        bird.physicsBody?.categoryBitMask = 1
        
        
        //cam.setScale(0.)
        //        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        //        borderBody.friction = 0.0
        //        self.physicsBody = borderBody

       
    }
    
    override func update(_ currentTime: CFTimeInterval)
    { //test to see if bird hits the bottom
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x, dy: accelerometerData.acceleration.y)
            
        }
        //cam.position.y = bird.position.y
        var positionx = bird.position.x
        var positiony = bird.position.y
        if positiony < 650
        {
            cam.position.y = 650
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
            //bird.physicsBody?.velocity = CGVector(dx: 0, dy: 700)
        }
        
    }

    
}
