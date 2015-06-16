//
//  GameViewController.swift
//
//  Created by Steve Smart on 6/6/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import UIKit
import SpriteKit

class GameController: UIViewController {

    // MARK: Properties
    var menuScene: MenuScene!
    
    // MARK: View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        
        menuScene = MenuScene(size: skView.bounds.size)
        menuScene.scaleMode = .AspectFill
        
        skView.presentScene(menuScene)
    }

    // MARK: UIViewController Attribute Methods
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
