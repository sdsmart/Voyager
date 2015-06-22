//
//  Projectile.swift
//  Voyager
//
//  Created by Steve Smart on 6/18/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class Projectile: SKSpriteNode {
    
    // MARK: Properties
    let player: Player
    let parentScene: SKScene
    
    var velocity = 0.0
    var damage = 0
    var cooldown = 0.0
    var cooldownTimer = NSTimer()
    
    // MARK: Initializers
    init(player: Player, parentScene: SKScene, imageNamed: String) {
        self.player = player
        self.parentScene = parentScene
        
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.position.x = player.position.x
        self.position.y = player.position.y + player.size.height / 3
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Uitility Methods
    func fire() {
        println("Override this method")
    }
    
    func weaponReady() {
        println("Override this method")
    }
}