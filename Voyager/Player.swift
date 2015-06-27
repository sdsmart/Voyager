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
    var isDead = false
    var movingRight = false
    var movingLeft = false
    var health = 100
    var gold = 0
    var laserOffCooldown = true
    var photonCannonLevel = 1
    var piercingBeamLevel = 1
    var clusterShotLevel = 1
    var specialOffCooldown = true {
        didSet {
            if let levelScene = parentScene as? LevelScene {
                if levelScene.levelState == LevelScene.LevelState.Main {
                    if specialOffCooldown == false {
                        levelScene.firePhotonCannonButton.enabled = false
                        levelScene.firePiercingBeamButton.enabled = false
                        levelScene.fireClusterShotButton.enabled = false
                    } else {
                        levelScene.firePhotonCannonButton.enabled = true
                        levelScene.firePiercingBeamButton.enabled = true
                        levelScene.fireClusterShotButton.enabled = true
                    }
                }
            }
        }
    }
    
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
    
    // MARK: Initialization Methods
    func initialize() {
        movingLeft = false
        movingRight = false
        laserOffCooldown = true
        specialOffCooldown = true
        health = 100
        velocity = 0.0
        acceleration = 0.0
        self.position.y = -(parentScene.size.height / 2) + Constants.distanceFromBottomOfScreen
        enabled = true
        
        parentScene.addChild(self)
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
            isDead = true
        }
    }
    
    // MARK: Observer Methods
    func firePhotonCannon() {
        if specialOffCooldown {
            let photonCannon = PhotonCannon(player: self, parentScene: parentScene)
            photonCannon.fire()
        }
    }
    
    func firePiercingBeam() {
        if specialOffCooldown {
            let piercingBeam = PiercingBeam(player: self, parentScene: parentScene)
            piercingBeam.fire()
        }
    }
    
    func fireClusterShot() {
        if specialOffCooldown {
            let clusterShot = ClusterShot(player: self, parentScene: parentScene)
            clusterShot.fire()
        }
    }
    
    // MARK: Enums & Constants
    enum SpecialAbility {
        case PhotonCannon
        case PiercingBeam
        case ClusterShot
    }
    
    struct Constants {
        static let distanceFromBottomOfScreen: CGFloat = 160.0
        static let friction: CGFloat = 0.25
        static let maxSpeed: CGFloat = 7.0
        static let acceleration: CGFloat = 0.70
        static let maxHealth = 100
        static let laserCooldown = 0.3
        static let specialCooldown = 2.0
        static let zPosition: CGFloat = 4.0
        static let collisionBoundary = CGSizeMake(35, 50)
        static let categoryBitmask: UInt32 = 0x1 << 0
    }
}