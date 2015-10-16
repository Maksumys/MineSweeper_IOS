//
//  GameViewController.swift
//  qwerty
//
//  Created by Максим Кузин on 12.10.15.
//  Copyright (c) 2015 Максим Кузин. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: MainMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = true
        
        // Create and configure the scene.
        skView.bounds.size.height *= 2
        skView.bounds.size.width *= 2
        scene = MainMenu(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        // Present the scene.
        skView.presentScene(scene)
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
