//
//  Hud.swift
//  SpaceShooter
//
//  Created by Steve Smart on 6/10/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import SpriteKit

class Hud {
    
    let background: SKSpriteNode
    let spriteNodes: [SKSpriteNode]
    
    init(backgroundImageName: String) {
        self.background = SKSpriteNode(imageNamed: backgroundImageName)
        
        var nodes = [SKSpriteNode]()
        nodes.append(self.background)
        
        self.spriteNodes = nodes
    }
    
    struct Constants {
        static let backgroundAlpha: CGFloat = 0.6
    }
}