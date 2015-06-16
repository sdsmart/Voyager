//
//  Bullet.swift
//
//  Created by Steve Smart on 6/10/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class Laser: SKSpriteNode {
    
    // MARK: Properties
    private let player: Player!
    private let containerSize: CGSize!
    
    var velocty = 1.0
    
    // MARK: Initializers
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
    
    // MARK: Uitility Methods
    func fire() {
        let locationOffScreen = containerSize.height
        let fireAction = SKAction.moveToY(locationOffScreen, duration: (1 / velocty))
        self.runAction(fireAction)
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let baseVelocity = 1.15
        
        static let zPosition: CGFloat = 1.0
    }
}