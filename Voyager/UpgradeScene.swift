//
//  ChooseSpecialScene.swift
//  Voyager
//
//  Created by Steve Smart on 6/20/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class UpgradeScene: SKScene {
    
    var parallaxBackground: ParallaxBackground!
    var player: Player!
    
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
        
        initializeParallaxBackground()
        initializePlayer()
    }
    
    private func initializeParallaxBackground() {
        self.addChild(parallaxBackground)
    }
    
    private func initializePlayer() {
        self.addChild(player)
        
        let initialFadeInAction = SKAction.fadeInWithDuration(GameController.Constants.transitionAnimationDuration)
        player.runAction(initialFadeInAction)
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
}