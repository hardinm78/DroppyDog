//
//  BGClass.swift
//  Droppy Dog
//
//  Created by Michael Hardin on 6/16/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit


class BGClass: SKSpriteNode {
    
    func moveBG(camera: SKCameraNode) {
        
        if self.position.y - self.size.height - 10 > camera.position.y {
            self.position.y -= self.size.height * 3
        }
        
        
    }
    
    
    
    
    
}
