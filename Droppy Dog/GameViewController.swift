//
//  GameViewController.swift
//  Droppy Dog
//
//  Created by Michael Hardin on 6/16/16.
//  Copyright (c) 2016 Michael Hardin. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds

var interstitial: GADInterstitial!

class GameViewController: UIViewController, UIAlertViewDelegate {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAndLoadInterstitial()
        
        
        if let scene = MainMenuScene(fileNamed:"MainMenu") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            skView.ignoresSiblingOrder = false
            
            
            skView.showsPhysics = false
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFit
            
            skView.presentScene(scene)
            
            
        }
    }
    
    func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-6381417154543225/5519422796")
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        //request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b" ]
        interstitial.loadRequest(request)
    }
    
    func runInterstitial(){
        if interstitial.isReady {
            interstitial.presentFromRootViewController(self)
        } else {
            print("Ad wasn't ready")
        }
    }
    

    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
        }
