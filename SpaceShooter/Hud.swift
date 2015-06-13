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
    private var healthMeter: SKSpriteNode
    
    init() {
        self.background = SKSpriteNode(imageNamed: ImageNames.hudBackground)
        self.background.zPosition = Constants.zPosition
        
        self.healthMeter = SKSpriteNode(imageNamed: ImageNames.alienFighter)
        self.healthMeter.zPosition = Constants.zPosition
        
        let texture = SKTexture(imageNamed: ImageNames.hudBackground)
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.zPosition = Constants.zPosition
        self.size = self.background.size
        self.addChild(background)
        self.addChild(healthMeter)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Constants {
        
        static let zPosition: CGFloat = 4
    }
}