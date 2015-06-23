//
//  Fighter.swift
//
//  Created by Steve Smart on 6/11/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class AlienFighter: SKSpriteNode {
    
    // MARK: Properties
    private let player: Player
    private let parentScene: SKScene
    
    var velocity = Constants.baseVelocity
    var health = Constants.baseHealth
    
    var hasBeenHitWithPiercingBeam = false
    
    // MARK: Initializers
    init(player: Player, parentScene: SKScene) {
        self.player = player
        self.parentScene = parentScene
        
        let texture = SKTexture(imageNamed: ImageNames.alienFighter)
        super.init(texture: texture, color: nil, size: texture.size())
        
        let edgeOffset = 30
        let shiftAmount = CGFloat(parentScene.size.width / 2) - CGFloat(edgeOffset / 2)
        let randomNumberForShipXPosition = CGFloat(arc4random_uniform(UInt32(parentScene.size.width) - UInt32(edgeOffset)))
        self.position.x =  randomNumberForShipXPosition - shiftAmount
        self.position.y = (parentScene.size.height / 2) + Constants.distanceToGetOffScreen
        self.zPosition = Constants.zPosition
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: Constants.collisionBoundary)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.categoryBitMask = Constants.categoryBitmask
        self.physicsBody!.contactTestBitMask = Player.Constants.categoryBitmask | Laser.Constants.categoryBitmask | PhotonCannon.Constants.categoryBitmask | PiercingBeam.Constants.categoryBitmask | ClusterShot.Constants.categoryBitmask
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Utility Methods
    func animate(animationType: AnimationType) {
        switch animationType {
        case .Down:
            animateDown()
        }
    }
    
    private func animateDown() {
        let animationAction = SKAction.moveToY(-((parentScene.size.height / 2) + Constants.distanceToGetOffScreen), duration: 1 / velocity)
        animationAction.timingMode = SKActionTimingMode.EaseIn
        self.runAction(animationAction)
    }
    
    func applyDamage(#damage: Int) {
        health -= damage
        
        if health <= 0 {
            self.removeFromParent()
        }
    }
    
    // MARK: Enums & Constants
    enum AnimationType {
        case Down
    }
    
    struct Constants {
        static let distanceToGetOffScreen: CGFloat = 30
        static let zPosition: CGFloat = 3.0
        static let collisionBoundary = CGSizeMake(20.0, 30.0)
        static let categoryBitmask: UInt32 = 0x1 << 10
        static let baseHealth = 10
        static let damage = 10
        static let baseVelocity = 0.30
    }
}