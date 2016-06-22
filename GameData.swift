//
//  GameData.swift
//  Droppy Dog
//
//  Created by Michael Hardin on 6/19/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import Foundation

class GameData: NSObject, NSCoding {
    
    struct Keys {
        
        static let EasyDifficultyScore = "EasyDifficultyScore"
        static let MediumDifficultyScore = "MediumDifficultyScore"
        static let HardDifficultyScore = "HardDifficultyScore"
        
        static let EasyDifficultyCoinScore = "EasyDifficultyCoinScore"
        static let MediumDifficultyCoinScore = "MediumDifficultyCoinScore"
        static let HardDifficultyCoinScore = "HardDifficultyCoinScore"
        
        static let EasyDifficulty = "EasyDifficulty"
        static let MediumDifficulty = "MediumDifficulty"
        static let HardDifficulty = "HardDifficulty"
        
        static let Music = "Music"
    }
    
    
    
    private var easyDifficultyScore = Int32()
    private var mediumDifficultyScore = Int32()
    private var hardDifficultyScore = Int32()
    
    
    private var easyDifficultyCoinScore = Int32()
    private var mediumDifficultyCoinScore = Int32()
    private var hardDifficultyCoinScore = Int32()
    
    private var easyDifficulty = false
    private var mediumDifficulty = false
    private var hardDifficulty = false
    
    
    private var isMusicOn = false
    
    
    override init() {}
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        self.easyDifficultyScore = aDecoder.decodeInt32ForKey(Keys.EasyDifficultyScore)
        self.easyDifficultyCoinScore = aDecoder.decodeInt32ForKey(Keys.EasyDifficultyCoinScore)
        self.mediumDifficultyScore = aDecoder.decodeInt32ForKey(Keys.MediumDifficultyScore)
        self.mediumDifficultyCoinScore = aDecoder.decodeInt32ForKey(Keys.MediumDifficultyCoinScore)
        self.hardDifficultyScore = aDecoder.decodeInt32ForKey(Keys.HardDifficultyScore)
        self.hardDifficultyCoinScore = aDecoder.decodeInt32ForKey(Keys.HardDifficultyCoinScore)
        
        self.easyDifficulty = aDecoder.decodeBoolForKey(Keys.EasyDifficulty)
        self.mediumDifficulty = aDecoder.decodeBoolForKey(Keys.MediumDifficulty)
        self.hardDifficulty = aDecoder.decodeBoolForKey(Keys.HardDifficulty)
        
        self.isMusicOn = aDecoder.decodeBoolForKey(Keys.Music)
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInt(self.easyDifficultyScore, forKey: Keys.EasyDifficultyScore)
        aCoder.encodeInt(self.easyDifficultyCoinScore, forKey: Keys.EasyDifficultyCoinScore)
        aCoder.encodeInt(self.mediumDifficultyScore, forKey: Keys.MediumDifficultyScore)
        aCoder.encodeInt(self.mediumDifficultyCoinScore, forKey: Keys.MediumDifficultyCoinScore)
        aCoder.encodeInt(self.hardDifficultyScore, forKey: Keys.HardDifficultyScore)
        aCoder.encodeInt(self.hardDifficultyCoinScore, forKey: Keys.HardDifficultyCoinScore)
        
        aCoder.encodeBool(self.easyDifficulty, forKey: Keys.EasyDifficulty)
        aCoder.encodeBool(self.mediumDifficulty, forKey: Keys.MediumDifficulty)
        aCoder.encodeBool(self.hardDifficulty, forKey: Keys.HardDifficulty)
        
        aCoder.encodeBool(self.isMusicOn, forKey: Keys.Music)
    }
    
    
    
    
    
    func setEasyDifficultyScore(easyDifficultyScore: Int32) {
        self.easyDifficultyScore = easyDifficultyScore
    }
    
    func setEasyDifficultyCoinScore(easyDifficultyCoinScore: Int32) {
        self.easyDifficultyCoinScore = easyDifficultyCoinScore
    }
    
    func getEasyDifficultyScore() -> Int32 {
        return self.easyDifficultyScore
    }
    
    func getEasyDifficultyCoinScore() -> Int32 {
        return self.easyDifficultyCoinScore
    }

    func setMediumDifficultyScore(mediumDifficultyScore: Int32) {
        self.mediumDifficultyScore = mediumDifficultyScore
    }
    
    func setMediumDifficultyCoinScore(mediumDifficultyCoinScore: Int32) {
        self.mediumDifficultyCoinScore = mediumDifficultyCoinScore
    }
    
    func getMediumDifficultyScore() -> Int32 {
        return self.mediumDifficultyScore
    }
    
    func getMediumDifficultyCoinScore() -> Int32 {
        return self.mediumDifficultyCoinScore
    }

    func setHardDifficultyScore(hardDifficultyScore: Int32) {
        self.hardDifficultyScore = hardDifficultyScore
    }
    
    func setHardDifficultyCoinScore(hardDifficultyCoinScore: Int32) {
        self.hardDifficultyCoinScore = hardDifficultyCoinScore
    }
    
    func getHardDifficultyScore() -> Int32 {
        return self.hardDifficultyScore
    }
    
    func getHardDifficultyCoinScore() -> Int32 {
        return self.hardDifficultyCoinScore
    }

    func setEasyDifficulty(easyDifficulty:Bool) {
        self.easyDifficulty = easyDifficulty
    }
    
    func getEasyDifficulty() -> Bool {
        return easyDifficulty
    }
    
    func setMediumDifficulty(mediumDifficulty:Bool) {
        self.mediumDifficulty = mediumDifficulty
    }
    
    func getMediumDifficulty() -> Bool {
        return mediumDifficulty
    }
    
    func setHardDifficulty(hardDifficulty:Bool) {
        self.hardDifficulty = hardDifficulty
    }
    
    func getHardDifficulty() -> Bool {
        return hardDifficulty
    }
    func setIsMusicOn(isMusicOn:Bool){
        self.isMusicOn = isMusicOn
    }
    func getIsMusicOn() -> Bool {
        return self.isMusicOn
    }
}



















