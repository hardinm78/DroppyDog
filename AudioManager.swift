//
//  AudioManager.swift
//  Droppy Dog
//
//  Created by Michael Hardin on 6/20/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import AVFoundation

class AudioManager {
 
    static let instance = AudioManager()
    private init() {}
    
    
    private var audioPlayer: AVAudioPlayer?
    
    func playBGMusic() {
        
        let url = NSBundle.mainBundle().URLForResource("Background music", withExtension: "mp3")
        
        var err: NSError?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url!)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
        } catch let err1 as NSError {
            err = err1
            print(err.debugDescription)
        }
        
    }
    
    func stopBGMusic() {
        if ((audioPlayer?.playing) != nil) {
            audioPlayer?.stop()
        }
    }
    
    
    func isAudioPlayerInitialized() -> Bool {
        return audioPlayer == nil 
    }
    
}