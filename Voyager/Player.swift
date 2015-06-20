//
//  Player.swift
//
//  Created by Steve Smart on 6/9/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    // MARK: Properties
    var enabled = false
    var movingRight = false
    var movingLeft = false
    var health = 100
    var gold = 0
    var specialAbility = SpecialAbility.HighEnergyShot
    var laserOffCooldown = true
    var laserCooldown = Constants.baseLaserCooldown
    var specialOffCooldown = true
    var highEnergyShotCooldown = Constants.baseHighEnergyShotCooldown
    var penetratingShotCooldown = Constants.basePenetratingShotCooldown
    var multiShotCooldown = Constants.baseMultiShotCooldown
    var hasItem = false
    
    private let parentScene: LevelScene
    private var velocity: CGFloat = 0.0
    private var acceleration: CGFloat = 0.0
    private var laserCooldownTimer = NSTimer()
    private var specialCooldownTimer = NSTimer()
    
    // MARK: Initializers
    init(parentScene: LevelScene) {
        self.parentScene = parentScene
        
        let texture = SKTexture(imageNamed: ImageNames.player)
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: Constants.collisionBoundary)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.categoryBitMask = Constants.categoryBitmask
        self.physicsBody!.contactTestBitMask = AlienFighter.Constants.categoryBitmask
        
        self.position.y = -(parentScene.size.height / 2) + Constants.distanceFromBottomOfScreen
        self.zPosition = Constants.zPosition
        self.alpha = CGFloat(0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Update Methods
    func update() {
        if enabled {
            updatePosition()
            updateVelocity()
            applyFriction()
            fireLaser()
        }
    }
    
    private func updatePosition() {
        self.position.x += velocity
        if self.position.x < -((parentScene.size.width / 2) - (self.size.width / 3)) {
            self.position.x = -((parentScene.size.width / 2) - (self.size.width / 3))
        } else if self.position.x > ((parentScene.size.width / 2) - (self.size.width / 3)) {
            self.position.x = ((parentScene.size.width / 2) - (self.size.width / 3))
        }
    }
    
    private func updateVelocity() {
        if movingRight {
            velocity += Constants.acceleration
        }
        if movingLeft {
            velocity -= Constants.acceleration
        }
        
        if velocity > Constants.maxSpeed {
            velocity = Constants.maxSpeed
        } else if velocity < -(Constants.maxSpeed) {
            velocity = -(Constants.maxSpeed)
        }
    }
    
    private func applyFriction() {
        if velocity > Constants.friction {
            velocity -= Constants.friction
        } else if velocity < -(Constants.friction) {
            velocity += Constants.friction
        } else {
            velocity = 0
        }
    }
    
    // Utility Methods
    func applyDamage(damage: Int) {
        health -= damage
        
        if health <= 0 {
            println("You Have Died!")
        }
    }
    
    func changeLaserFireRate(#shotsPerSecond: Double) {
        laserCooldown = 1 / shotsPerSecond
    }
    
    // MARK: Observer Methods
    func useItem() {
        println("Using Item!")
    }
    
    func useSpecial() {
        fireSpecial()
    }
    
    func chargeLaser() {
        if parentScene.gamePaused {
            laserCooldownTimer.invalidate()
            laserCooldownTimer = NSTimer.scheduledTimerWithTimeInterval(laserCooldown, target: self,
                selector: Selector("chargeLaser"), userInfo: nil, repeats: false)
        } else {
            laserOffCooldown = true
        }
    }
    
    func chargeSpecial() {
        if parentScene.gamePaused {
            specialCooldownTimer.invalidate()
            resetSpecialCooldownTimer()
        } else {
            specialOffCooldown = true
            parentScene.useSpecialButton.enabled = true
        }
    }
    
    private func fireLaser() {
        if laserOffCooldown {
            laserOffCooldown = false
            
            let laser = Laser(player: self, parentScene: self.parentScene)
            laser.fire()
            
            laserCooldownTimer = NSTimer.scheduledTimerWithTimeInterval(laserCooldown, target: self,
                selector: Selector("chargeLaser"), userInfo: nil, repeats: false)
        }
    }
    
    private func fireSpecial() {
        if specialOffCooldown {
            specialOffCooldown = false
            parentScene.useSpecialButton.enabled = false
            
            switch specialAbility {
            case .HighEnergyShot:
                let highEnergyShot = HighEnergyShot(player: self, parentScene: parentScene)
                highEnergyShot.fire()
            case .PenetratingShot:
                let penetratingShot = PenetratingShot(player: self, parentScene: parentScene)
                penetratingShot.fire()
            case .MultiShot:
                let multiShot = MultiShot(player: self, parentScene: parentScene)
                multiShot.fire()
            }
            
            resetSpecialCooldownTimer()
        }
    }
    
    private func resetSpecialCooldownTimer() {
        switch specialAbility {
        case .HighEnergyShot:
            specialCooldownTimer = NSTimer.scheduledTimerWithTimeInterval(highEnergyShotCooldown, target: self,
                selector: Selector("chargeSpecial"), userInfo: nil, repeats: false)
        case .PenetratingShot:
            specialCooldownTimer = NSTimer.scheduledTimerWithTimeInterval(penetratingShotCooldown, target: self,
                selector: Selector("chargeSpecial"), userInfo: nil, repeats: false)
        case .MultiShot:
            specialCooldownTimer = NSTimer.scheduledTimerWithTimeInterval(multiShotCooldown, target: self,
                selector: Selector("chargeSpecial"), userInfo: nil, repeats: false)
        }
    }
    
    // MARK: Enums & Constants
    enum SpecialAbility {
        case HighEnergyShot
        case PenetratingShot
        case MultiShot
    }
    
    struct Constants {
        static let friction: CGFloat = 0.25
        static let maxSpeed: CGFloat = 7.0
        static let acceleration: CGFloat = 0.70
        static let maxHealth = 100
        static let baseLaserCooldown = 0.35
        static let baseHighEnergyShotCooldown = 3.0
        static let basePenetratingShotCooldown = 2.0
        static let baseMultiShotCooldown = 2.5
        static let distanceFromBottomOfScreen: CGFloat = 135.0
        static let zPosition: CGFloat = 4.0
        static let collisionBoundary = CGSizeMake(35, 50)
        static let categoryBitmask: UInt32 = 0x1 << 0
    }
}