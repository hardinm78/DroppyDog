//
//  OptionsScene.swift
//  Droppy Dog
//
//  Created by Michael Hardin on 6/17/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit


class OptionsScene: SKScene {
    
    
    private var easyBtn: SKSpriteNode?
    private var mediumBtn: SKSpriteNode?
    private var hardBtn: SKSpriteNode?
    
    private var sign: SKSpriteNode?
    
    override func didMoveToView(view: SKView) {
        initializeVariables()
        setSign()
    }
    
    func initializeVariables() {
        
        easyBtn = self.childNodeWithName("Easy Button")as? SKSpriteNode!
        mediumBtn = self.childNodeWithName("Medium Button")as? SKSpriteNode!
        hardBtn = self.childNodeWithName("Hard Button")as? SKSpriteNode!
        sign = self.childNodeWithName("Sign")as? SKSpriteNode!
    }
    
    func setSign() {
        if GameManager.instance.getEasyDifficulty(){
            sign?.position.y = (easyBtn?.position.y)!
        }else if GameManager.instance.getMediumDifficulty(){
            sign?.position.y = (mediumBtn?.position.y)!
        }else if GameManager.instance.getHardDifficulty(){
            sign?.position.y = (hardBtn?.position.y)!
        }
    }
    
    
    private func setDifficulty(difficulty:String) {
        
      switch difficulty {
        case "easy":
            GameManager.instance.setEasyDifficulty(true)
            GameManager.instance.setMediumDifficulty(false)
            GameManager.instance.setHardDifficulty(false)
            break
        case "medium":
            GameManager.instance.setEasyDifficulty(false)
            GameManager.instance.setMediumDifficulty(true)
            GameManager.instance.setHardDifficulty(false)
            break
        case "hard":
            GameManager.instance.setEasyDifficulty(false)
            GameManager.instance.setMediumDifficulty(false)
            GameManager.instance.setHardDifficulty(true)
            break
        default:
            break
        }
        
        GameManager.instance.saveData()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            
            if nodeAtPoint(location) == easyBtn {
                print("easy")
                sign?.position.y = (easyBtn?.position.y)!
                setDifficulty("easy")
            }
            if nodeAtPoint(location) == mediumBtn {
                print("medium")
                sign?.position.y = (mediumBtn?.position.y)!
                setDifficulty("medium")
            }
            if nodeAtPoint(location) == hardBtn {
                print("hard")
                sign?.position.y = (hardBtn?.position.y)!
                setDifficulty("hard")
            }
            
            sign?.zPosition = 4
            
            if nodeAtPoint(location).name == "Back" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene?.scaleMode = .AspectFill
                self.view?.presentScene(scene!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: 1.5))
            }
        
        }
    }
}
