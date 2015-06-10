//
//  LevelScene.swift
//  SpaceShooter
//
//  Created by Steve Smart on 6/9/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import SpriteKit

class LevelScene: SKScene {
   
    var parallaxBackground: ParallaxBackground!
    
    var player: Player!
    
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
        
        if parallaxBackground != nil {
            for bg in parallaxBackground.backgrounds! {
                self.addChild(bg)
            }
        }
        
        initializePlayer()
    }
    
    private func initializePlayer() {
        player = Player(imageNamed: Player.imageName)
        
        let playerPhysicsBody = SKPhysicsBody()
        player.physicsBody = playerPhysicsBody
        player.physicsBody!.dynamic = false
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.allowsRotation = false
        
        player.velocity = Player.initialVelocity
        player.acceleration = Player.initialAcceleration
        player.position.y = Player.initialPositionY
        
        self.addChild(player)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        updatePlayer()
    }
    
    private func updatePlayer() {
        player.position.y += player.velocity
        player.velocity += player.acceleration
        
        if player.velocity > Player.maxSpeed {
            player.velocity = Player.maxSpeed
        } else if player.velocity < -(Player.maxSpeed) {
            player.velocity = -(Player.maxSpeed)
        }
        
        if player.velocity > Player.friction {
            player.velocity -= Player.friction
        } else if player.velocity < -(Player.friction) {
            player.velocity += Player.friction
        } else {
            player.velocity = 0
        }
        
        if player.acceleration > 0 {
            player.acceleration -= Player.friction
        }
    }
}
