//
//  Hud.swift
//  DeepSpace
//
//  Created by Steve Smart on 6/10/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import SpriteKit

class Hud: SKSpriteNode {
    
    private let background: SKSpriteNode
    private let healthMeter: SKSpriteNode
    private let levelHeader: SKSpriteNode
    private let scoreHeader: SKSpriteNode
    private let switchWeaponHeader: SKSpriteNode
    private let useItemHeader: SKSpriteNode
    
    private var healthBar: SKSpriteNode
    private var levelValue: SKLabelNode
    private var scoreValue: SKLabelNode
    
    init(containerSize: CGSize) {
        self.background = SKSpriteNode(imageNamed: ImageNames.hudBackground)
        self.background.zPosition = Constants.zPosition
        
        self.healthMeter = SKSpriteNode(imageNamed: ImageNames.hudHealthMeter)
        self.healthMeter.zPosition = Constants.zPosition
        self.healthMeter.position.x = -(containerSize.width / 2) + (self.healthMeter.size.width / 2) + Constants.healthMeterHorizontalOffset
        self.healthMeter.position.y = (self.background.size.height / 2) - (self.healthMeter.size.height / 2) - Constants.healthMeterVerticalOffset
        
        self.healthBar = SKSpriteNode(imageNamed: ImageNames.hudHealthBar)
        self.healthBar.anchorPoint = CGPointMake(CGFloat(0.0), CGFloat(0.5))
        self.healthBar.zPosition = Constants.zPosition
        self.healthBar.position.x = -(containerSize.width / 2) + Constants.healthBarHorizontalOffset
        self.healthBar.position.y = (self.background.size.height / 2) - (self.healthBar.size.height / 2) - Constants.healthBarVerticalOffset
        
        self.levelHeader = SKSpriteNode(imageNamed: ImageNames.hudLevelHeader)
        self.levelHeader.zPosition = Constants.zPosition
        self.levelHeader.position.x = -(containerSize.width / 2) + (self.levelHeader.size.width / 2) + Constants.levelHeaderHorizontalOffset
        self.levelHeader.position.y = (self.background.size.height / 2) - (self.levelHeader.size.height / 2) - Constants.levelHeaderVerticalOffset
        
        self.levelValue = SKLabelNode(fontNamed: Constants.levelValueFontName)
        self.levelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        self.levelValue.fontSize = Constants.levelValueFontSize
        self.levelValue.fontColor = Constants.levelValueColor
        self.levelValue.zPosition = Constants.zPosition
        self.levelValue.position.x = -(containerSize.width / 2) + Constants.levelValueHorizontalOffset
        self.levelValue.position.y = (self.background.size.height / 2) - Constants.levelValueVerticalOffset
        
        self.scoreHeader = SKSpriteNode(imageNamed: ImageNames.hudScoreHeader)
        self.scoreHeader.zPosition = Constants.zPosition
        self.scoreHeader.position.x = -(containerSize.width / 2) + (self.scoreHeader.size.width / 2) + Constants.scoreHeaderHorizontalOffset
        self.scoreHeader.position.y = (self.background.size.height / 2) - (self.scoreHeader.size.height / 2) - Constants.scoreHeaderVerticalOffset
        
        self.scoreValue = SKLabelNode(fontNamed: Constants.scoreValueFontName)
        self.scoreValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        self.scoreValue.fontSize = Constants.scoreValueFontSize
        self.scoreValue.fontColor = Constants.scoreValueColor
        self.scoreValue.zPosition = Constants.zPosition
        self.scoreValue.position.x = -(containerSize.width / 2) + Constants.scoreValueHorizontalOffset
        self.scoreValue.position.y = (self.background.size.height / 2) - Constants.scoreValueVerticalOffset
        
        self.switchWeaponHeader = SKSpriteNode(imageNamed: ImageNames.hudSwitchWeaponHeader)
        self.switchWeaponHeader.zPosition = Constants.zPosition
        self.switchWeaponHeader.position.x = (containerSize.width / 2) - Constants.switchWeaponHeaderHorizontalOffset
        self.switchWeaponHeader.position.y = (self.background.size.height / 2) - Constants.switchWeaponHeaderVerticalOffset
        
        self.useItemHeader = SKSpriteNode(imageNamed: ImageNames.hudUseItemHeader)
        self.useItemHeader.zPosition = Constants.zPosition
        self.useItemHeader.position.x = (containerSize.width / 2) - Constants.useItemHeaderHorizontalOffset
        self.useItemHeader.position.y = (self.background.size.height / 2) - Constants.useItemHeaderVerticalOffset
        
        let texture = SKTexture(imageNamed: ImageNames.hudBackground)
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.zPosition = Constants.zPosition
        self.size = self.background.size
        self.addChild(background)
        self.addChild(healthMeter)
        self.addChild(healthBar)
        self.addChild(scoreHeader)
        self.addChild(scoreValue)
        self.addChild(levelHeader)
        self.addChild(levelValue)
        self.addChild(switchWeaponHeader)
        self.addChild(useItemHeader)
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
    
    func updateLevelValue(#level: Int) {
        var newLevel = level
        if newLevel < 1 {
            newLevel = 1
        }
        
        levelValue.text = "\(newLevel)"
    }
    
    func updateScoreValue(#score: Int) {
        var newScore = score
        if newScore > 999999999 {
            newScore = 999999999
        } else if newScore < 0 {
            newScore = 0
        }
        
        scoreValue.text = "\(newScore)"
    }
    
    struct Constants {
        static let healthMeterHorizontalOffset: CGFloat = 11.0
        static let healthMeterVerticalOffset: CGFloat = 12.0
        
        static let healthBarHorizontalOffset: CGFloat = 75.0
        static let healthBarVerticalOffset: CGFloat = 14.0
        
        static let levelHeaderHorizontalOffset: CGFloat = 10.0
        static let levelHeaderVerticalOffset: CGFloat = 33.0
        
        static let levelValueHorizontalOffset: CGFloat = 58.0
        static let levelValueVerticalOffset: CGFloat = 44.0
        static let levelValueFontName = "HelveticaNeue-Medium"
        static let levelValueFontSize: CGFloat = 14.0
        static let levelValueColor = UIColor(red: 0, green: 255/255, blue: 255/255, alpha: 1.0)
        
        static let scoreHeaderHorizontalOffset: CGFloat = 77.0
        static let scoreHeaderVerticalOffset: CGFloat = 32.0
        
        static let scoreValueHorizontalOffset: CGFloat = 131.0
        static let scoreValueVerticalOffset: CGFloat = 44.0
        static let scoreValueFontName = "HelveticaNeue-Medium"
        static let scoreValueFontSize: CGFloat = 14.0
        static let scoreValueColor = UIColor(red: 0, green: 192/255, blue: 0, alpha: 1.0)
        
        static let switchWeaponHeaderHorizontalOffset: CGFloat = 116.0
        static let switchWeaponHeaderVerticalOffset: CGFloat = 20.0
        
        static let useItemHeaderHorizontalOffset: CGFloat = 41.0
        static let useItemHeaderVerticalOffset: CGFloat = 20.0
        
        static let zPosition: CGFloat = 4.0
    }
}