//
//  GameScene.swift
//  Cloud Jump
//
//  Created by  on 1/2/20.
//  Copyright © 2020 goodstuff. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    var bird = SKSpriteNode()
    let cam = SKCameraNode()
    //var cloud1 = SKSpriteNode()

//player.run(SKAction.applyImpulse(CGVector(dx: 100, dy: 20), duration: 0))
    override func didMove(to view: SKView)
    {
//        let background = SKSpriteNode(imageNamed: "sky")
//        background.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
//        background.zPosition = -100
//        background.size = CGSize(width: view.frame.width, height: view.frame.height)
//        addChild(background)
        //create contact body 
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0.0
        self.physicsBody = borderBody
        bird = self.childNode(withName: "bird") as! SKSpriteNode
        bird.texture = SKTexture(imageNamed: "bird")
        self.camera = cam
        cam.setScale(1)
        //cam.setScale(0.)

       
    }
    
    override func update(_ currentTime: CFTimeInterval)
    { //test to see if bird hits the bottom
        var positionx = bird.position.x
        var positiony = bird.position.y
 
        cam.position.x = frame.width/2
        cam.position.y = bird.position.y
    }

    
}
