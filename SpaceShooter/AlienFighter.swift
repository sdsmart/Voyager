//
//  Fighter.swift
//  SpaceShooter
//
//  Created by Steve Smart on 6/11/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class AlienFighter: SKSpriteNode {
    
    static var canSpawn = false
    
    let player: Player
    let containerSize: CGSize
    
    var velocity = 0.30
    var spawnRate = 0.75
    
    init(imageNamed: String, player: Player, containerSize: CGSize) {
        self.player = player
        self.containerSize = containerSize
        
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: nil, size: texture.size())
        
        let edgeOffset = 30
        let shiftAmount = CGFloat(containerSize.width / 2) - CGFloat(edgeOffset / 2)
        let randomNumberForShipXPosition = CGFloat(arc4random_uniform(UInt32(containerSize.width) - UInt32(edgeOffset)))
        self.position.x =  randomNumberForShipXPosition - shiftAmount
        self.position.y = (containerSize.height / 2) + Constants.distanceToGetOffScreen
        self.zPosition = Constants.zPosition
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(animationType: AnimationType) {
        switch animationType {
        case .Down:
            let animationAction = SKAction.moveToY(-((containerSize.height / 2) + Constants.distanceToGetOffScreen), duration: 1 / velocity)
            animationAction.timingMode = SKActionTimingMode.EaseIn
            self.runAction(animationAction)
        }
    }
    
    enum AnimationType {
        case Down
    }
    
    struct Constants {
        static let distanceToGetOffScreen: CGFloat = 100
        
        static let zPosition: CGFloat = 2.0
    }
}