//
//  GameplayScene.swift
//  Droppy Dog
//
//  Created by Michael Hardin on 6/16/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit
import GoogleMobileAds  
class GameplayScene:SKScene, SKPhysicsContactDelegate {
    
    var cloudsController = CloudsController()
    
    var mainCamera: SKCameraNode?
    var bg1: BGClass?
    var bg2: BGClass?
    var bg3: BGClass?
    
    var player: Player?
    var canMove = false
    var moveLeft = false
    
    var center: CGFloat?
    
    private var acceleration = CGFloat()
    private var cameraSpeed = CGFloat()
    private var maxSpeed = CGFloat()
    
    
    private let playerMinX = CGFloat(-250)
    private let playerMaxX = CGFloat(250)
    
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    
    
    let distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(-160)
    let maxX = CGFloat(160)
    
    private var pausePanel: SKSpriteNode?
    
    
    override func didMoveToView(view: SKView) {
       
        
        
        
        initializeVariables()
      self.runAction(SKAction.playSoundFileNamed("Coin Sound.wav", waitForCompletion: false))
      self.runAction(SKAction.playSoundFileNamed("Life Sound.wav", waitForCompletion: false))
       // self.runAction(SKAction.playSoundFileNamed("Dead.wav", waitForCompletion: false))
    }
    
    override func update(currentTime: NSTimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        createNewClouds()
        player?.setScore()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Life" {
            
            self.runAction(SKAction.playSoundFileNamed("Life Sound.wav", waitForCompletion: false))
            
            secondBody.node?.removeFromParent()
            GameplayController.instance.incrementLife()
            
        }else if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
           
            self.runAction(SKAction.playSoundFileNamed("Coin Sound.wav", waitForCompletion: false))
            secondBody.node?.removeFromParent()
            GameplayController.instance.incrementCoin()
            
        }else if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Cloud" {
            
            
            
            GameplayController.instance.life! -= 1
            
            if GameplayController.instance.life! >= 0 {
            GameplayController.instance.lifeText!.text = "x\(GameplayController.instance.life!)"
            } else {
                createEndScorePanel()
            }
            
            
            
            self.runAction(SKAction.playSoundFileNamed("Dead.wav", waitForCompletion: true))
            
            firstBody.node?.removeFromParent()
            
            let seconds = 1.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                
               self.scene?.paused = true
                
            })
            
            
            
            
            
            let dead = SKSpriteNode(imageNamed:"dead")
            dead.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: dead.size.width, height: dead.size.height-20))
            dead.position = (player?.position)!
            
            self.addChild(dead)
           
            
            
            
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(self.playerDied), userInfo: nil, repeats: false)
            
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location).name != "Pause" && nodeAtPoint(location).name != "Resume" && nodeAtPoint(location).name != "Quit"{
                if self.scene!.paused == false {
                    
                    if location.x > center {
                        moveLeft = false
                        player?.animatePlayer(moveLeft)
                    }else {
                        moveLeft = true
                        player?.animatePlayer(moveLeft)
                    }
                }
            }
            
            
            
            if nodeAtPoint(location).name == "Pause" {
                pausePanel?.removeFromParent()
                self.scene!.paused = true
                createPausePanel()
            }
            
            if nodeAtPoint(location).name == "Resume" {
                pausePanel?.removeFromParent()
                self.scene!.paused = false
                
            }
            if nodeAtPoint(location).name == "Quit" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene?.scaleMode = .AspectFit
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontalWithDuration(1))
                
            }
            
        }
        canMove = true
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    
    func initializeVariables() {
        physicsWorld.contactDelegate = self
        
        
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        player = self.childNodeWithName("Player") as? Player
        player?.initializePlayerAndAnimations()
        
        
        mainCamera = self.childNodeWithName("MainCamera") as? SKCameraNode!
        getBackgrounds()
        getLabels()
        GameplayController.instance.initializeVariables()
        
        cloudsController.arrangeCloudsInScene(self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, player: player!, initialClouds: true)
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
        setCameraSpeed()
    }
    func getBackgrounds() {
        
        bg1 = self.childNodeWithName("BG 1") as? BGClass!
        bg2 = self.childNodeWithName("BG 2") as? BGClass!
        bg3 = self.childNodeWithName("BG 3") as? BGClass!
    }
    
    func managePlayer(){
        if canMove{
            player?.movePlayer(moveLeft)
        }
        
        if player?.position.x > playerMaxX{
            player!.position.x = playerMaxX
        }
        if player?.position.x < playerMinX{
            player!.position.x = playerMinX
        }
        
        if (player?.position.y)! - player!.size.height * 3.7 > mainCamera?.position.y {
            self.scene?.paused = true
            GameplayController.instance.life! -= 1
            
            if GameplayController.instance.life! >= 0 {
                GameplayController.instance.lifeText!.text = "x\(GameplayController.instance.life!)"
            } else {
                createEndScorePanel()
            }
            
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2), target: self, selector: #selector(self.playerDied), userInfo: nil, repeats: false)

        }
        if (player?.position.y)! + player!.size.height * 3.7 < mainCamera?.position.y {
            self.scene?.paused = true
            GameplayController.instance.life! -= 1
            
            if GameplayController.instance.life! >= 0 {
                GameplayController.instance.lifeText!.text = "x\(GameplayController.instance.life!)"
            } else {
                createEndScorePanel()
            }
            
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2), target: self, selector: #selector(self.playerDied), userInfo: nil, repeats: false)

        }
        
    }
    func moveCamera() {
        cameraSpeed += acceleration
        if cameraSpeed > maxSpeed {
            cameraSpeed = maxSpeed
        }
        
        self.mainCamera?.position.y -= cameraSpeed
    }
    
    func manageBackgrounds() {
        bg1?.moveBG(mainCamera!)
        bg2?.moveBG(mainCamera!)
        bg3?.moveBG(mainCamera!)
        
        
    }
    
    
    func createNewClouds(){
        if cameraDistanceBeforeCreatingNewClouds > mainCamera?.position.y{
            cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
            
            cloudsController.arrangeCloudsInScene(self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX , maxX: maxX, player: player!, initialClouds: false)
            
            checkForChildsOutOfScreen()
        }
    }
    
    func checkForChildsOutOfScreen(){
        for child in children {
            if child.position.y > (mainCamera?.position.y)! + self.scene!.size.height {
                let childName = child.name?.componentsSeparatedByString(" ")
                if childName![0] != "BG" {
                    print("removedChild:\(child.name!)")
                    child.removeFromParent()
                }
            }
        }
    }
    
    func getLabels() {
        GameplayController.instance.scoreText = self.mainCamera!.childNodeWithName("Score Text") as? SKLabelNode!
        GameplayController.instance.coinText = self.mainCamera!.childNodeWithName("Coin Score") as? SKLabelNode!
        GameplayController.instance.lifeText = self.mainCamera!.childNodeWithName("Life Score") as? SKLabelNode!
    }
    
    
    
    func createPausePanel() {
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        let resumeBtn = SKSpriteNode(imageNamed: "Resume Button")
        let quitBtn = SKSpriteNode(imageNamed: "Quit Button 2")
        
        
        pausePanel?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pausePanel?.xScale = 1.6
        pausePanel?.yScale = 1.6
        pausePanel?.zPosition = 5
        pausePanel?.position = CGPoint(x: self.mainCamera!.frame.size.width / 2, y: self.mainCamera!.frame.size.height / 2)
        
        resumeBtn.name = "Resume"
        resumeBtn.zPosition = 6
        resumeBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        resumeBtn.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! + 25)
        
        quitBtn.name = "Quit"
        quitBtn.zPosition = 6
        quitBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quitBtn.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! - 45)
        
        pausePanel?.addChild(resumeBtn)
        pausePanel?.addChild(quitBtn)
        
        self.mainCamera?.addChild(pausePanel!)
        
    }
    
    func createEndScorePanel() {
        let endScorePanel = SKSpriteNode(imageNamed: "Show Score")
        let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-DemiBold")
        let coinLabel = SKLabelNode(fontNamed: "AvenirNext-DemiBold")
        
        endScorePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        endScorePanel.zPosition = 8
        endScorePanel.xScale = 1.5
        endScorePanel.yScale = 1.5
        
        scoreLabel.fontSize = 50
        coinLabel.fontSize = 50
        
        scoreLabel.zPosition = 7
        coinLabel.zPosition = 7
        
        
        scoreLabel.text = String(GameplayController.instance.score!)
        coinLabel.text = String(GameplayController.instance.coin!)
        
        
        endScorePanel.addChild(scoreLabel)
        endScorePanel.addChild(coinLabel)
        
        endScorePanel.position = CGPoint(x: (mainCamera?.frame.size.width)!/2, y: (mainCamera?.frame.size.height)!/2)
        scoreLabel.position = CGPoint(x: endScorePanel.position.x - 60, y:endScorePanel.position.y + 10)
        coinLabel.position = CGPoint(x: endScorePanel.position.x - 60, y:endScorePanel.position.y - 105)
        
        
        
        
        
        mainCamera?.addChild(endScorePanel)
        
    }
    
    private func setCameraSpeed() {
        if GameManager.instance.getEasyDifficulty() {
            acceleration = 0.001
            cameraSpeed = 1.5
            maxSpeed = 4
        }else if GameManager.instance.getMediumDifficulty() {
            acceleration = 0.002
            cameraSpeed = 2.0
            maxSpeed = 6
        }else if GameManager.instance.getHardDifficulty() {
            acceleration = 0.003
            cameraSpeed = 2.5
            maxSpeed = 8
        }
    }
    
    
    @objc private func playerDied() {
        
        
        
        if GameplayController.instance.life >= 0 {
            GameManager.instance.gameRestartedPlayerDied = true
            
            
            let scene = GameplayScene(fileNamed: "GameplayScene")
            scene!.scaleMode = .AspectFit
            self.view?.presentScene(scene!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration:(1.7)))
        } else {
            
            if GameManager.instance.getEasyDifficulty(){
                let highScore = GameManager.instance.getEasyDifficultyScore()
                let highCoinScore = GameManager.instance.getEasyDifficultyCoinScore()
                
                if highScore < GameplayController.instance.score {
                    
                    GameManager.instance.setEasyDifficultyScore(GameplayController.instance.score!)
                }
                if highCoinScore < GameplayController.instance.coin {
                    GameManager.instance.setEasyDifficultyCoinScore(GameplayController.instance.coin!)
                }
                
            } else if GameManager.instance.getMediumDifficulty() {
                let highScore = GameManager.instance.getMediumDifficultyScore()
                let highCoinScore = GameManager.instance.getMediumDifficultyCoinScore()
                
                if highScore < GameplayController.instance.score {
                    
                    GameManager.instance.setMediumDifficultyScore(GameplayController.instance.score!)
                }
                if highCoinScore < GameplayController.instance.coin {
                    GameManager.instance.setMediumDifficultyCoinScore(GameplayController.instance.coin!)
                }
                
            } else if GameManager.instance.getHardDifficulty() {
                let highScore = GameManager.instance.getHardDifficultyScore()
                let highCoinScore = GameManager.instance.getHardDifficultyCoinScore()
                
                if highScore < GameplayController.instance.score {
                    
                    GameManager.instance.setHardDifficultyScore(GameplayController.instance.score!)
                }
                if highCoinScore < GameplayController.instance.coin {
                    GameManager.instance.setHardDifficultyCoinScore(GameplayController.instance.coin!)
                }
            }
            GameManager.instance.saveData()
            
//              
            
            if interstitial.isReady {
                let currentViewController:UIViewController=UIApplication.sharedApplication().keyWindow!.rootViewController!
                
                interstitial.presentFromRootViewController(currentViewController)
            } else {
                print("Ad wasn't ready")
            }
            
            interstitial = GADInterstitial(adUnitID: "ca-app-pub-6381417154543225/5519422796")
            let request = GADRequest()
            interstitial.loadRequest(request)
            
            let scene = MainMenuScene(fileNamed: "MainMenu")
            scene?.scaleMode = .AspectFit
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontalWithDuration(1))
            
            
        }
        
        
    }
    
    
}








































