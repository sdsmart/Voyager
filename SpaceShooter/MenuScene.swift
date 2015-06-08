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
    
    var parallaxBackground: ParallaxBackground!
    
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
        
        parallaxBackground = ParallaxBackground(imageNames: BackgroundConstants.imageNames, baseScrollDuration: BackgroundConstants.baseScrollDuration, scrollDurationChangeRatio: BackgroundConstants.ScrollDurationChangeRatio, containerHeight: self.size.height, numberOfTiles: BackgroundConstants.numberOfTiles, scrollDown: true)
        parallaxBackground.beginScrolling()
        
        if parallaxBackground.backgrounds != nil {
            for bg in parallaxBackground.backgrounds! {
                self.addChild(bg)
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
    
    private struct BackgroundConstants {
        static let imageNames = ["menu_background_1", "menu_background_2", "menu_background_3"]
        static let baseScrollDuration = 40.0
        static let ScrollDurationChangeRatio = 0.30
        static let numberOfTiles = 3
    }
}