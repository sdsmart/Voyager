//
//  Player.swift
//
//  Created by Steve Smart on 6/9/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    // MARK: Properties
    var velocity: CGFloat = 0.0
    var acceleration: CGFloat = 0.0
    
    var canShoot = false
    
    var healthPercentage: Double = 1.0
    var score = 0
    
    var fireRateTimeInterval: Double = 0.15
    
    // MARK: Initializers
    init() {
        let texture = SKTexture(imageNamed: ImageNames.player)
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: Constants.collisionBoundary)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.categoryBitMask = Constants.categoryBitmask
        self.physicsBody!.contactTestBitMask = AlienFighter.Constants.categoryBitmask
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let friction: CGFloat = 0.25
        static let maxSpeed: CGFloat = 7.0
        static let acceleration: CGFloat = 0.70
        
        static let distanceFromBottomOfScreen: CGFloat = 135.0
        
        static let zPosition: CGFloat = 3.0
        
        static let collisionBoundary = CGSizeMake(35, 50)
        static let categoryBitmask: UInt32 = 0x1 << 0
    }
}