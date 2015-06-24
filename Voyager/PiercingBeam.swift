//
//  PiercingBeam.swift
//  Voyager
//
//  Created by Steve Smart on 6/18/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class PiercingBeam: Projectile {
    
    // MARK: Properties
    var piercingPower = Constants.basePiercingPower
    
    // MARK: Initializers
    init(player: Player, parentScene: SKScene) {
        super.init(player: player, parentScene: parentScene, imageNamed: ImageNames.piercingBeam)
        
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
        switch player.piercingBeamLevel {
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
        if let scene = parentScene as? LevelScene {
            scene.useSpecialButton.enabled = false
        }
        self.player.specialOffCooldown = false
        
        let locationOffScreen = self.parentScene.size.height
        let fireAction = SKAction.moveToY(locationOffScreen, duration: (1 / velocity))
        self.parentScene.addChild(self)
        self.runAction(fireAction)
        
        self.cooldownTimer = NSTimer.scheduledTimerWithTimeInterval(self.cooldown, target: self,
            selector: Selector("weaponReady"), userInfo: nil, repeats: false)
    }
    
    func reducePiercingPower() {
        piercingPower--
        
        if piercingPower <= 0 {
            self.removeFromParent()
        }
    }
    
    // MARK: Observer Methods
    override func weaponReady() {
        if let scene = parentScene as? LevelScene {
            if scene.gamePaused {
                self.cooldownTimer.invalidate()
                self.cooldownTimer = NSTimer.scheduledTimerWithTimeInterval(self.cooldown, target: self,
                    selector: Selector("weaponReady"), userInfo: nil, repeats: false)
            } else {
                self.player.specialOffCooldown = true
                scene.useSpecialButton.enabled = true
            }
        }
    }
    
    // MARK: Enums & Constants
    struct Constants {
        struct LevelOneStats {
            static let velocity = 1.00
            static let cooldown = 2.5
            static let damage = 15
        }

        static let baseUpgradeCost = 100
        static let upgradeIncrementRatio = 0.5
        static let basePiercingPower = 2
        static let zPosition: CGFloat = 2.0
        static let collisionBoundary = CGSizeMake(5.5, 55.0)
        static let categoryBitmask: UInt32 = 0x1 << 3
    }
}