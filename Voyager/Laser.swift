//
//  Bullet.swift
//
//  Created by Steve Smart on 6/10/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class Laser: Projectile {
    
    // MARK: Initializers
    init(player: Player, parentScene: SKScene) {
        super.init(player: player, parentScene: parentScene, imageNamed: ImageNames.laser)
        
        initializePhysics()
        initializeStats()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Initialization Methods
    private func initializePhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: Constants.collisionBoundary)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.categoryBitMask = Constants.categoryBitmask
        self.physicsBody!.contactTestBitMask = AlienFighter.Constants.categoryBitmask
        self.physicsBody!.usesPreciseCollisionDetection = true
    }
    
    private func initializeStats() {
        switch player.laserLevel {
        case 1:
            self.velocity = Constants.LevelOneStats.velocity
            self.cooldown = Constants.LevelOneStats.cooldown
            self.damage = Constants.LevelOneStats.damage
        default:
            break
        }
    }
    
    // MARK: Uitility Methods
    override func fire() {
        self.player.laserOffCooldown = false
        
        let locationOffScreen = self.parentScene.size.height
        let fireAction = SKAction.moveToY(locationOffScreen, duration: (1 / velocity))
        self.parentScene.addChild(self)
        self.runAction(fireAction)
        
        self.cooldownTimer = NSTimer.scheduledTimerWithTimeInterval(self.cooldown, target: self,
            selector: Selector("weaponReady"), userInfo: nil, repeats: false)
    }
    
    // MARK: Observer Methods
    override func weaponReady() {
        if let scene = parentScene as? LevelScene {
            if scene.gamePaused {
                self.cooldownTimer.invalidate()
                self.cooldownTimer = NSTimer.scheduledTimerWithTimeInterval(self.cooldown, target: self,
                    selector: Selector("weaponReady"), userInfo: nil, repeats: false)
            } else {
                self.player.laserOffCooldown = true
            }
        }
    }
    
    // MARK: Enums & Constants
    struct Constants {
        struct LevelOneStats {
            static let velocity = 0.75
            static let cooldown = 0.35
            static let damage = 10
        }
        
        static let zPosition: CGFloat = 1.0
        static let collisionBoundary = CGSizeMake(3.0, 20.0)
        static let categoryBitmask: UInt32 = 0x1 << 1
    }
}