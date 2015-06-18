//
//  Player.swift
//
//  Created by Steve Smart on 6/9/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    // MARK: Properties
    var enabled = false
    var movingRight = false
    var movingLeft = false
    var hasItem = false
    var health = 100
    var gold = 100
    
    private let parentScene: LevelScene
    private var velocity: CGFloat = 0.0
    private var acceleration: CGFloat = 0.0
    private var canFire = true
    private var fireRateTimeInterval: Double = Constants.baseFireRate
    private var fireRateTimer = NSTimer()
    
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
            updateProjectiles()
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
    
    private func updateProjectiles() {
        if canFire {
            canFire = false
            
            let laser = Laser(player: self, containerSize: parentScene.size)
            
            parentScene.addChild(laser)
            
            laser.fire()
            
            let fireRateTimer = NSTimer.scheduledTimerWithTimeInterval(fireRateTimeInterval, target: self,
                selector: Selector("prepareProjectile"), userInfo: nil, repeats: false)
        }
    }
    
    // Utility Methods
    func applyDamage(damage: Int) {
        health -= damage
        
        if health <= 0 {
            println("You Have Died!")
        }
    }
    
    func changeFireRate(#shotsPerSecond: Double) {
        fireRateTimeInterval = 1 / shotsPerSecond
    }
    
    // MARK: Observer Methods
    func prepareProjectile() {
        if parentScene.gamePaused {
            fireRateTimer.invalidate()
            fireRateTimer = NSTimer.scheduledTimerWithTimeInterval(fireRateTimeInterval, target: self,
                selector: Selector("prepareProjectile"), userInfo: nil, repeats: false)
        } else {
            canFire = true
        }
    }
    
    func useItem() {
        println("Using Item!")
    }
    
    func useSpecial() {
        println("Using Special!")
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let friction: CGFloat = 0.25
        static let maxSpeed: CGFloat = 7.0
        static let acceleration: CGFloat = 0.70
        static let maxHealth = 100
        static let baseFireRate: Double = (1 / 4)
        
        static let distanceFromBottomOfScreen: CGFloat = 135.0
        
        static let zPosition: CGFloat = 3.0
        
        static let collisionBoundary = CGSizeMake(35, 50)
        static let categoryBitmask: UInt32 = 0x1 << 0
    }
}