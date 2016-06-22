//
//  HighscoreScene.swift
//  Droppy Dog
//
//  Created by Michael Hardin on 6/17/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit

class HighscoreScene: SKScene {
    
    private var scoreLabel: SKLabelNode?
    private var coinLabel: SKLabelNode?
    
    override func didMoveToView(view: SKView) {
        getReference()
        setScore()
    }
    
    private func setScore(){
        
        if GameManager.instance.getEasyDifficulty() {
            scoreLabel!.text = String(GameManager.instance.getEasyDifficultyScore())
            coinLabel!.text = String(GameManager.instance.getEasyDifficultyCoinScore())
        } else if GameManager.instance.getMediumDifficulty() {
            scoreLabel!.text = String(GameManager.instance.getMediumDifficultyScore())
            coinLabel!.text = String(GameManager.instance.getMediumDifficultyCoinScore())
        } else if GameManager.instance.getHardDifficulty() {
            scoreLabel!.text = String(GameManager.instance.getHardDifficultyScore())
            coinLabel!.text = String(GameManager.instance.getHardDifficultyCoinScore())
        }
        
        
    }
    
    private func getReference() {
        scoreLabel = self.childNodeWithName("Score Label") as? SKLabelNode!
        coinLabel = self.childNodeWithName("Coin Label") as? SKLabelNode!
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location).name == "Back" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene?.scaleMode = .AspectFit
                self.view?.presentScene(scene!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: 1.5))
                
            }
        }
    }
    
    
}
