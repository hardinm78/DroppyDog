//
//  GameController.swift
//  Droppy Dog
//
//  Created by Michael Hardin on 6/18/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import Foundation


class GameManager {
    
    static let instance = GameManager()
    private init() {}
    
    private var gameData: GameData?
    
    
    var gameStartedFromMainMenu = false
    var gameRestartedPlayerDied = false
    
    func initializeGameData() {
        
        if !NSFileManager.defaultManager().fileExistsAtPath(getFilePath()){
            gameData = GameData()
            
            gameData?.setEasyDifficultyScore(0)
            gameData?.setEasyDifficultyCoinScore(0)
            gameData?.setMediumDifficultyScore(0)
            gameData?.setMediumDifficultyCoinScore(0)
            gameData?.setHardDifficultyScore(0)
            gameData?.setHardDifficultyCoinScore(0)
            
            gameData?.setEasyDifficulty(false)
            gameData?.setMediumDifficulty(true)
            gameData?.setHardDifficulty(false)
            
            gameData?.setIsMusicOn(false)
            
            saveData()
        }
        loadData()
    }
    
    
    func loadData(){
        
        gameData = NSKeyedUnarchiver.unarchiveObjectWithFile(getFilePath() as String) as? GameData
        
    }
    func saveData() {
        if gameData != nil {
            NSKeyedArchiver.archiveRootObject(gameData!, toFile: getFilePath() as String)
        }
    }
    
    private func getFilePath() -> String {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as NSURL!
        return url!.URLByAppendingPathComponent("Game Data").path!
        
        
    }
    
    
    func setEasyDifficultyScore(easyDifficultyScore: Int32){
        self.gameData!.setEasyDifficultyScore(easyDifficultyScore)
    }
    func getEasyDifficultyScore() -> Int32 {
        return self.gameData!.getEasyDifficultyScore()
    }
    
    func setMediumDifficultyScore(mediumDifficultyScore: Int32){
        self.gameData!.setMediumDifficultyScore(mediumDifficultyScore)
    }
    func getMediumDifficultyScore() -> Int32 {
        return self.gameData!.getMediumDifficultyScore()
    }

    func setHardDifficultyScore(hardDifficultyScore: Int32){
        self.gameData!.setHardDifficultyScore(hardDifficultyScore)
    }
    func getHardDifficultyScore() -> Int32 {
        return self.gameData!.getHardDifficultyScore()
    }

    func setEasyDifficultyCoinScore(easyDifficultyCoinScore: Int32){
        self.gameData!.setEasyDifficultyCoinScore(easyDifficultyCoinScore)
    }
    func getEasyDifficultyCoinScore() -> Int32 {
        return self.gameData!.getEasyDifficultyCoinScore()
    }
    
    func setMediumDifficultyCoinScore(mediumDifficultyCoinScore: Int32){
        self.gameData!.setMediumDifficultyCoinScore(mediumDifficultyCoinScore)
    }
    func getMediumDifficultyCoinScore() -> Int32 {
        return self.gameData!.getMediumDifficultyCoinScore()
    }
    
    func setHardDifficultyCoinScore(hardDifficultyCoinScore: Int32){
        self.gameData!.setHardDifficultyCoinScore(hardDifficultyCoinScore)
    }
    func getHardDifficultyCoinScore() -> Int32 {
        return self.gameData!.getHardDifficultyCoinScore()
    }

    func setEasyDifficulty(easyDifficulty:Bool){
        self.gameData!.setEasyDifficulty(easyDifficulty)
    }
    func getEasyDifficulty() -> Bool {
       return self.gameData!.getEasyDifficulty()
    }
    
    func setMediumDifficulty(mediumDifficulty:Bool){
        self.gameData!.setMediumDifficulty(mediumDifficulty)
    }
    func getMediumDifficulty() -> Bool {
        return self.gameData!.getMediumDifficulty()
    }
    
    func setHardDifficulty(hardDifficulty:Bool){
        self.gameData!.setHardDifficulty(hardDifficulty)
    }
    func getHardDifficulty() -> Bool {
        return self.gameData!.getHardDifficulty()
    }
    
    func setIsMusicOn(isMusicOn:Bool){
        self.gameData!.setIsMusicOn(isMusicOn)
    }
    
    func getIsMusicOn() -> Bool {
        return self.gameData!.getIsMusicOn()
    }
    
    
    
    
}