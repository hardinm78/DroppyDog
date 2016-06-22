//
//  CollectiblesController.swift
//  Droppy Dog
//
//  Created by Michael Hardin on 6/18/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit


class CollectiblesController {
    
    
   
    
    
    func getCollectible() -> SKSpriteNode {
        
        var collectible = SKSpriteNode()
        
        if Int(randomBetweenNumbers(0, secondNum: 7)) > 4 {
            
            if GameplayController.instance.life < 2 {
                collectible = SKSpriteNode(imageNamed: "Life")
                collectible.name = "Life"
                collectible.physicsBody = SKPhysicsBody(rectangleOfSize: collectible.size)
            } else {
                collectible.name = "Empty"
            }
            
        } else {
            collectible = SKSpriteNode(imageNamed: "Coin")
            collectible.name = "Coin"
            collectible.physicsBody = SKPhysicsBody(circleOfRadius: collectible.size.height/2)
        }
        collectible.physicsBody?.affectedByGravity = false
        collectible.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectibles
        collectible.physicsBody?.collisionBitMask = ColliderType.Player
        collectible.zPosition = 2
        
        return collectible
        
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
 
    
    
    
}



















