//
//  Bullet.swift
//
//  Created by Steve Smart on 6/10/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class Laser: Projectile {
    
    // MARK: Properties
    var velocity = Constants.baseVelocity
    
    // MARK: Initializers
    init(player: Player, parentScene: LevelScene) {
        super.init(player: player, parentScene: parentScene, imageNamed: ImageNames.laser)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: Constants.collisionBoundary)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.categoryBitMask = Constants.categoryBitmask
        self.physicsBody!.contactTestBitMask = AlienFighter.Constants.categoryBitmask
        self.physicsBody!.usesPreciseCollisionDetection = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Uitility Methods
    override func fire() {
        let locationOffScreen = self.parentScene.size.height
        let fireAction = SKAction.moveToY(locationOffScreen, duration: (1 / velocity))
        self.parentScene.addChild(self)
        self.runAction(fireAction)
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let baseVelocity = 0.75
        static let damage = 10
        static let zPosition: CGFloat = 1.0
        static let collisionBoundary = CGSizeMake(3.0, 20.0)
        static let categoryBitmask: UInt32 = 0x1 << 1
    }
}