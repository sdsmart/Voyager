//
//  Hud.swift
//  SpaceShooter
//
//  Created by Steve Smart on 6/10/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import SpriteKit

class Hud: SKSpriteNode {
    
    private let background: SKSpriteNode
    private let healthMeter: SKSpriteNode
    private var healthBar: SKSpriteNode
    
    init() {
        self.background = SKSpriteNode(imageNamed: ImageNames.hudBackground)
        self.background.zPosition = Constants.zPosition
        
        self.healthMeter = SKSpriteNode(imageNamed: ImageNames.healthMeter)
        self.healthMeter.zPosition = Constants.zPosition
        self.healthMeter.position.x = -(self.background.size.width / 2) + (self.healthMeter.size.width / 2) + Constants.healthMeterHorizontalOffset
        self.healthMeter.position.y = (self.background.size.height / 2) - (self.healthMeter.size.height / 2) - Constants.healthMeterVerticalOffset
        
        self.healthBar = SKSpriteNode(imageNamed: ImageNames.healthBar)
        self.healthBar.anchorPoint = CGPointMake(CGFloat(0.0), CGFloat(0.5))
        self.healthBar.zPosition = Constants.zPosition
        self.healthBar.position.x = -(self.background.size.width / 2) + Constants.healthBarHorizontalOffset
        self.healthBar.position.y = (self.background.size.height / 2) - (self.healthBar.size.height / 2) - Constants.healthBarVerticalOffset
        
        let texture = SKTexture(imageNamed: ImageNames.hudBackground)
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.zPosition = Constants.zPosition
        self.size = self.background.size
        self.addChild(background)
        self.addChild(healthMeter)
        self.addChild(healthBar)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateHealthBar(#healthPercentage: Double) {
        var newHealth = healthPercentage
        if newHealth < 0.0 {
            newHealth = 0.0
        } else if newHealth > 1.0 {
            newHealth = 1.0
        }
        
        let oldHealthBarWidth = healthBar.size.width
        healthBar.size.width = oldHealthBarWidth * CGFloat(newHealth)
    }
    
    struct Constants {
        static let healthMeterHorizontalOffset: CGFloat = 34.0
        static let healthMeterVerticalOffset: CGFloat = 12.0
        static let healthBarHorizontalOffset: CGFloat = 90.0
        static let healthBarVerticalOffset: CGFloat = 16.5
        
        static let zPosition: CGFloat = 4.0
    }
}