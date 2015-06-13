//
//  ParallaxBackground.swift
//  SpaceShooter
//
//  Created by Steve Smart on 6/7/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import SpriteKit

class ParallaxBackground: SKSpriteNode {
    
    private var backgrounds: [SKSpriteNode]?
    private var baseScrollDuration: Double = 0.0
    private var scrollDurationChangeRatio: Double = 1.0
    private var initialPositionY: CGFloat = 0.0
    private var finalPositionY: CGFloat = 0.0
    private var containerHeight: CGFloat = 0.0
    private var numberOfTiles: Int = 1
    private var scrollDown: Bool = true
    
    init(imageNames: [String], containerHeight: CGFloat, scrollDown: Bool) {
        let texture = SKTexture(imageNamed: imageNames.first!)
        
        self.scrollDown = scrollDown
        
        if baseScrollDuration >= 0.0 {
            self.baseScrollDuration = Constants.baseScrollDuration
        }
        
        if scrollDurationChangeRatio >= 0.0 && Constants.ScrollDurationChangeRatio <= 1.0 {
            self.scrollDurationChangeRatio = Constants.ScrollDurationChangeRatio
        }
        
        if containerHeight >= 0.0 {
            self.containerHeight = containerHeight
            if scrollDown {
                self.initialPositionY = -(containerHeight / 2)
            } else {
                self.initialPositionY = (containerHeight / 2)
            }
        }
        
        if numberOfTiles >= 1 {
            self.numberOfTiles = Constants.numberOfTiles
        }
        
        if imageNames.isEmpty == false {
            var bgs = [SKSpriteNode]()
            for imageName in imageNames {
                let bg = SKSpriteNode(imageNamed: imageName)
                bgs.append(bg)
            }
            self.backgrounds = bgs
        } else {
            backgrounds = nil
        }
        
        super.init(texture: texture, color: nil, size: texture.size())
        
        if let bgs = backgrounds {
            if scrollDown {
                self.finalPositionY = -((bgs.first!.size.height / CGFloat(self.numberOfTiles)) + (self.containerHeight / CGFloat(2)))
            } else {
                self.finalPositionY = (bgs.first!.size.height / CGFloat(self.numberOfTiles)) + (self.containerHeight / CGFloat(2))
            }
            for bg in bgs {
                self.addChild(bg)
            }
        }        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginScrolling() {
        if backgrounds != nil {
            for (i, bg) in enumerate(backgrounds!) {
                let timeInterval = baseScrollDuration * pow(scrollDurationChangeRatio, Double(i))
                let scrollBackgroundImageOneAction = SKAction.moveToY(finalPositionY, duration: timeInterval)
                let resetBackgroundImageOneAction = SKAction.moveToY(initialPositionY, duration: 0)
                
                if scrollDown {
                    bg.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.0))
                } else {
                    bg.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(1.0))
                }
                bg.position.y = initialPositionY
                bg.runAction(SKAction.repeatActionForever(SKAction.sequence([scrollBackgroundImageOneAction, resetBackgroundImageOneAction])))
            }
        }
    }
    
    struct Constants {
        static let baseScrollDuration = 40.0
        static let ScrollDurationChangeRatio = 0.30
        static let numberOfTiles = 3
        
        static let zPosition: CGFloat = 0
    }
}