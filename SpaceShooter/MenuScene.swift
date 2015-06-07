//
//  GameScene.swift
//  SpaceShooter
//
//  Created by Steve Smart on 6/6/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    var backgroundOne = SKSpriteNode(imageNamed: BackgroundConstants.BackgroundOne.imageName)
    
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
        backgroundOne.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0))
        
        initializeBackgrounds()
        
        self.addChild(backgroundOne)
    }
    
    private func initializeBackgrounds() {
        initializeBackgroundOne()
        
        // Initialize other parallax backgrounds here
    }
    
    private func initializeBackgroundOne() {
        let initialPositionY = -(self.size.height / 2)
        let yPositionToScrollTo = -(CGFloat(backgroundOne.size.height / CGFloat(BackgroundConstants.BackgroundOne.numberOfTiles)) + (self.size.height / CGFloat(2)))
        
        backgroundOne.position.y = initialPositionY
        
        let scrollBackgroundImageOneAction = SKAction.moveToY(yPositionToScrollTo, duration: BackgroundConstants.BackgroundOne.scrollDuration)
        let resetBackgroundImageOneAction = SKAction.moveToY(initialPositionY, duration: 0)
        
        backgroundOne.runAction(SKAction.repeatActionForever(SKAction.sequence([scrollBackgroundImageOneAction, resetBackgroundImageOneAction])))
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
    
    private struct BackgroundConstants {
        struct BackgroundOne {
            static let imageName = "menu_background_1"
            static let scrollDuration = 30.0
            static let numberOfTiles = 3
        }
    }
}