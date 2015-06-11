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
    var hud: Hud!
    var player: Player!
    var beginMessage: SKSpriteNode!
    
    var userReady = false
    var movingRight = false
    var movingLeft = false
    
    var moveRightTouch: UITouch?
    var moveLeftTouch: UITouch?
    
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
        
        initializeParallaxBackground()
        initializeOverlayMessages()
        initializePlayer()
        initializeHud()
    }
    
    private func initializeParallaxBackground() {
        if parallaxBackground != nil {
            for bg in parallaxBackground.backgrounds! {
                self.addChild(bg)
            }
        }
    }
    
    private func initializeOverlayMessages() {
        beginMessage = SKSpriteNode(imageNamed: ImageNames.beginMessageImageName)
        
        self.addChild(beginMessage)
    }
    
    private func initializePlayer() {
        player = Player(imageNamed: ImageNames.playerImageName)
        
        player.position.y = -(self.size.height / 2) + Player.Constants.distanceFromBottomOfScreen
        player.alpha = CGFloat(0)
        player.zPosition = 2
        
        self.addChild(player)
        
        let initialFadeInAction = SKAction.fadeInWithDuration(MenuScene.Constants.transitionAnimationDuration)
        player.runAction(initialFadeInAction)
    }
    
    private func initializeHud() {
        hud = Hud(backgroundImageName: ImageNames.hudBackgroundImageName)
        hud.background.position.y = -((self.size.height / 2) + (hud.background.size.height / 2))
        hud.background.alpha = Hud.Constants.backgroundAlpha
        
        for node in hud.spriteNodes {
            self.addChild(hud.background)
            
            let action = SKAction.moveToY(-((self.size.height / 2) - (hud.background.size.height / 2)), duration: MenuScene.Constants.transitionAnimationDuration)
            node.runAction(action)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let touchLocation = touch.locationInView(self.view)
            
            let hudBoundary = (self.size.height) - hud.size.height
            
            if touchLocation.x >= (self.size.width / 2) && touchLocation.y <= hudBoundary {
                movingRight = true
                moveRightTouch = touch
            } else if touchLocation.x < (self.size.width / 2) && touchLocation.y <= hudBoundary {
                movingLeft = true
                moveLeftTouch = touch
            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            if userReady == false && touch.tapCount == 2 {
                beginPlay()
            }
            
            if touch === moveRightTouch {
                movingRight = false
                moveRightTouch = nil
            } else if touch === moveLeftTouch {
                movingLeft = false
                moveLeftTouch = nil
            }
        }
    }
    
    private func beginPlay() {
        beginMessage.removeFromParent()
        
        userReady = true
        player.canShoot = true
    }
    
    override func update(currentTime: NSTimeInterval) {
        if userReady {
            updatePlayer()
            updateLasers()
        }
    }
    
    private func updatePlayer() {
        updatePlayerPosition()
        updatePlayerVelocity()
        applyFrictionToPlayer()
    }
    
    private func updatePlayerPosition() {
        player.position.x += player.velocity
        if player.position.x < -((self.size.width / 2) - (player.size.width / 3)) {
            player.position.x = -((self.size.width / 2) - (player.size.width / 3))
        } else if player.position.x > ((self.size.width / 2) - (player.size.width / 3)) {
            player.position.x = ((self.size.width / 2) - (player.size.width / 3))
        }
    }
    
    private func updatePlayerVelocity() {
        if movingRight {
            player.velocity += Player.Constants.acceleration
        }
        if movingLeft {
            player.velocity -= Player.Constants.acceleration
        }
        
        if player.velocity > Player.Constants.maxSpeed {
            player.velocity = Player.Constants.maxSpeed
        } else if player.velocity < -(Player.Constants.maxSpeed) {
            player.velocity = -(Player.Constants.maxSpeed)
        }
    }
    
    private func applyFrictionToPlayer() {
        if player.velocity > Player.Constants.friction {
            player.velocity -= Player.Constants.friction
        } else if player.velocity < -(Player.Constants.friction) {
            player.velocity += Player.Constants.friction
        } else {
            player.velocity = 0
        }
    }
    
    private func updateLasers() {
        if player.canShoot {
            player.canShoot = false
            
            let laser = Laser(imageNamed: ImageNames.laserImageName)
            laser.position = player.position
            laser.zPosition = player.zPosition - 1
            
            self.addChild(laser)
            
            let locationOffScreen = self.size.height
            let laserShootAction = SKAction.moveToY(locationOffScreen, duration: (1 / laser.velocty))
            laser.runAction(laserShootAction)
            
            let fireRateTimer = NSTimer.scheduledTimerWithTimeInterval(laser.fireRateTimeInterval, target: self,
                selector: Selector("fireRateTimerEndedEventHandler"), userInfo: nil, repeats: false)
        }
    }
    
    func fireRateTimerEndedEventHandler() {
        player.canShoot = true
    }
}
