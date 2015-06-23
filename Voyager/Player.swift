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
    var gold = 100
    var hasItem = false
    var specialAbility = SpecialAbility.PhotonCannon
    var laserOffCooldown = true
    var specialOffCooldown = true
    var photonCannonLevel = 0
    var piercingBeamLevel = 0
    var clusterShotLevel = 0
    
    
    private let parentScene: SKScene
    private var velocity: CGFloat = 0.0
    private var acceleration: CGFloat = 0.0
    private var laserCooldownTimer = NSTimer()
    private var specialCooldownTimer = NSTimer()
    
    // MARK: Initializers
    init(parentScene: SKScene) {
        self.parentScene = parentScene
        
        let texture = SKTexture(imageNamed: ImageNames.player)
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: Constants.collisionBoundary)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.categoryBitMask = Constants.categoryBitmask
        self.physicsBody!.contactTestBitMask = AlienFighter.Constants.categoryBitmask
        
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
    
    private func fireLaser() {
        if laserOffCooldown {
            let laser = Laser(player: self, parentScene: self.parentScene)
            laser.fire()
        }
    }
    
    // Utility Methods
    func applyDamage(damage: Int) {
        health -= damage
        
        if health <= 0 {
            println("You Have Died!")
        }
    }
    
    // MARK: Observer Methods
    func useItem() {
        println("Using Item!")
    }
    
    func fireSpecial() {
        if specialOffCooldown {
            switch specialAbility {
            case .PhotonCannon:
                let photonCannon = PhotonCannon(player: self, parentScene: parentScene)
                photonCannon.fire()
            case .PiercingBeam:
                let piercingBeam = PiercingBeam(player: self, parentScene: parentScene)
                piercingBeam.fire()
            case .ClusterShot:
                let clusterShot = ClusterShot(player: self, parentScene: parentScene)
                clusterShot.fire()
            }
        }
    }
    
    // MARK: Enums & Constants
    enum SpecialAbility {
        case PhotonCannon
        case PiercingBeam
        case ClusterShot
    }
    
    struct Constants {
        static let friction: CGFloat = 0.25
        static let maxSpeed: CGFloat = 7.0
        static let acceleration: CGFloat = 0.70
        static let maxHealth = 100
        static let zPosition: CGFloat = 4.0
        static let collisionBoundary = CGSizeMake(35, 50)
        static let categoryBitmask: UInt32 = 0x1 << 0
    }
}