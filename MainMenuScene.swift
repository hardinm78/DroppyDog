//
//  MainMenuScene.swift
//  Droppy Dog
//
//  Created by Michael Hardin on 6/17/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    
    private var musicBtn: SKSpriteNode?
    
    private let musicON = SKTexture(imageNamed:"Music On Button")
    private let musicOFF = SKTexture(imageNamed:"Music Off Button")
    
    
    override func didMoveToView(view: SKView) {
        
        musicBtn = childNodeWithName("Music") as? SKSpriteNode!
        
        GameManager.instance.initializeGameData()
        setMusic()
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location).name == "Start Game" {
                GameManager.instance.gameStartedFromMainMenu = true
                
                let scene = GameplayScene(fileNamed: "GameplayScene")
                scene!.scaleMode = .AspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenHorizontalWithDuration(1.7))
            }
            
            if nodeAtPoint(location).name == "Highscore" {
                let scene = HighscoreScene(fileNamed: "HighscoreScene")
                scene!.scaleMode = .AspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVerticalWithDuration(1))
                
            }
            if nodeAtPoint(location).name == "Options" {
                let scene = OptionsScene(fileNamed: "OptionsScene")
                scene!.scaleMode = .AspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVerticalWithDuration(1))
            }
            if nodeAtPoint(location).name == "Quit" {
                print("quit")
            }
            if nodeAtPoint(location) == musicBtn {
                handleMusicButton()
            }
        }
    }
    private func setMusic() {
        if GameManager.instance.getIsMusicOn(){
            if AudioManager.instance.isAudioPlayerInitialized() {
                AudioManager.instance.playBGMusic()
               
            }
            musicBtn?.texture = musicOFF
        }
    }
    
    private func handleMusicButton() {
        if GameManager.instance.getIsMusicOn() {
            
            AudioManager.instance.stopBGMusic()
            GameManager.instance.setIsMusicOn(false)
            musicBtn?.texture = musicON
        }else {
            AudioManager.instance.playBGMusic()
            GameManager.instance.setIsMusicOn(true)
            musicBtn?.texture = musicOFF
        }
        GameManager.instance.saveData()
        
    }
    
    
}

























