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
    var movingRight = false
    var moveRightTouch: UITouch?
    var movingLeft = false
    var moveLeftTouch: UITouch?
    
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
        player.position.y = Player.initialPositionY
        player.alpha = CGFloat(0)
        
        self.addChild(player)
        
        let initialFadeIn = SKAction.fadeInWithDuration(2.0)
        player.runAction(initialFadeIn)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let touchLocation = touch.locationInView(self.view)
            
            if touchLocation.x >= (self.size.width / 2) {
                movingRight = true
                moveRightTouch = touch
            } else if touchLocation.x < (self.size.width / 2) {
                movingLeft = true
                moveLeftTouch = touch
            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            
            if touch === moveRightTouch {
                movingRight = false
                moveRightTouch = nil
            } else if touch === moveLeftTouch {
                movingLeft = false
                moveLeftTouch = nil
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        updatePlayer()
    }
    
    private func updatePlayer() {
        player.position.x += player.velocity
        if player.position.x < -((self.size.width / 2) - (player.size.width / 3)) {
            player.position.x = -((self.size.width / 2) - (player.size.width / 3))
        } else if player.position.x > ((self.size.width / 2) - (player.size.width / 3)) {
            player.position.x = ((self.size.width / 2) - (player.size.width / 3))
        }
        
        if movingRight {
            player.velocity += Player.acceleration
        }
        if movingLeft {
            player.velocity -= Player.acceleration
        }
        
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
    }
}
