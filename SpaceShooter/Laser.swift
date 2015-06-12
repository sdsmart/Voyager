//
//  Bullet.swift
//  SpaceShooter
//
//  Created by Steve Smart on 6/10/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class Laser: SKSpriteNode {
    
    let player: Player!
    let containerSize: CGSize!
    
    var fireRateTimeInterval = 0.15
    var velocty = 1.0
    
    init(imageNamed: String, player: Player, containerSize: CGSize) {
        self.player = player
        self.containerSize = containerSize
        
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.position.x = player.position.x
        self.position.y = player.position.y + player.size.height / 3
        self.zPosition = Laser.Constants.zPosition
        self.velocty = Constants.baseVelocity
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fire() {
        let locationOffScreen = containerSize.height
        let fireAction = SKAction.moveToY(locationOffScreen, duration: (1 / velocty))
        self.runAction(fireAction)
    }
    
    struct Constants {
        static let baseVelocity = 1.15
        
        static let zPosition: CGFloat = 1
    }
}