//
//  MultiShot.swift
//  Voyager
//
//  Created by Steve Smart on 6/18/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class MultiShot: Projectile {
    
    // MARK: Properties
    var velocity = Constants.baseVelocity
    
    // MARK: Initializers
    override init(player: Player, parentScene: LevelScene) {
        super.init(player: player, parentScene: parentScene)
        
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
        let fireStraightAction = SKAction.moveToY(locationOffScreen, duration: (1 / velocity))
        self.parentScene.addChild(self)
        self.runAction(fireStraightAction)
        
        let leftShot = MultiShot(player: self.player, parentScene: self.parentScene)
        let fireLeftAction = SKAction.moveTo(CGPointMake((self.player.position.x - Constants.horizontalOffset), locationOffScreen), duration: (1 / velocity))
        self.parentScene.addChild(leftShot)
        leftShot.runAction(fireLeftAction)
        
        let rightShot = MultiShot(player: self.player, parentScene: self.parentScene)
        let fireRightAction = SKAction.moveTo(CGPointMake((self.player.position.x + Constants.horizontalOffset), locationOffScreen), duration: (1 / velocity))
        self.parentScene.addChild(rightShot)
        rightShot.runAction(fireRightAction)
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let baseVelocity = 1.00
        static let damage = 10
        static let horizontalOffset: CGFloat = 125.0
        static let zPosition: CGFloat = 2.0
        static let collisionBoundary = CGSizeMake(10.0, 10.0)
        static let categoryBitmask: UInt32 = 0x1 << 4
    }
}