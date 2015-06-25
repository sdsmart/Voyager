//
//  PhotonCannon.swift
//  Voyager
//
//  Created by Steve Smart on 6/18/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class PhotonCannon: Projectile {
    
    // MARK: Initializers
    init(player: Player, parentScene: SKScene) {
        super.init(player: player, parentScene: parentScene, imageNamed: ImageNames.photonCannon)
        
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
        switch player.photonCannonLevel {
        case 1:
            self.velocity = Constants.Stats.LevelOne.velocity
            self.damage = Constants.Stats.LevelOne.damage
        default:
            break
        }
    }
    
    // MARK: Uitility Methods
    override func fire() {
        self.player.specialOffCooldown = false
        
        let locationOffScreen = self.parentScene.size.height
        let fireAction = SKAction.moveToY(locationOffScreen, duration: (1 / velocity))
        self.parentScene.addChild(self)
        self.runAction(fireAction)
        
        self.cooldownTimer = NSTimer.scheduledTimerWithTimeInterval(Player.Constants.specialCooldown, target: self,
            selector: Selector("weaponReady"), userInfo: nil, repeats: false)
    }
    
    // MARK: Observer Methods
    override func weaponReady() {
        if let scene = parentScene as? LevelScene {
            if scene.gamePaused {
                self.cooldownTimer.invalidate()
                self.cooldownTimer = NSTimer.scheduledTimerWithTimeInterval(Player.Constants.specialCooldown, target: self,
                    selector: Selector("weaponReady"), userInfo: nil, repeats: false)
            } else {
                self.player.specialOffCooldown = true
            }
        } else {
            self.player.specialOffCooldown = true
        }
    }
    
    // MARK: Enums & Constants
    struct Constants {
        struct Stats {
            struct LevelOne {
                static let velocity = 1.00
                static let damage = 25
            }
        }
        
        static let baseUpgradeCost = 100
        static let upgradeIncrementRatio = 0.5
        static let zPosition: CGFloat = 2.0
        static let collisionBoundary = CGSizeMake(27.0, 27.0)
        static let categoryBitmask: UInt32 = 0x1 << 2
    }
}
