//
//  LevelScene.swift
//  SpaceShooter
//
//  Created by Steve Smart on 6/9/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import UIKit
import SpriteKit

class LevelScene: SKScene {
    
    var parallaxBackground: ParallaxBackground!
    var hud: Hud?
    var player: Player?
    var currentLevel = 1
    var levelLabel: SKSpriteNode?
    var instructionsLabel: SKSpriteNode?
    var useItemButton: UIButton!
    var switchWeaponButton: UIButton!
    var pauseButton: UIButton!
    
    private var currentPhase = Phase.One
    private var userReady = false
    private var movingRight = false
    private var movingLeft = false
    private var moveRightTouch: UITouch?
    private var moveLeftTouch: UITouch?
    
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
        
        initializeParallaxBackground()
        initializeOverlayMessages()
        initializePlayer()
        initializeHud()
    }
    
    private func initializeParallaxBackground() {
        self.addChild(parallaxBackground)
    }
    
    private func initializeOverlayMessages() {
        if levelLabel == nil {
            levelLabel = SKSpriteNode(imageNamed: ImageNames.levelLabel)
        }
        levelLabel!.position.y = Constants.levelLabelPosition
        
        if instructionsLabel == nil {
            instructionsLabel = SKSpriteNode(imageNamed: ImageNames.instructionsLabel)
        }
        instructionsLabel!.position.y = Constants.instructionsLabelPosition
        
        self.addChild(levelLabel!)
        self.addChild(instructionsLabel!)
    }
    
    private func initializePlayer() {
        if player == nil {
            player = Player(imageNamed: ImageNames.player)
        }
        player!.position.y = -(self.size.height / 2) + Player.Constants.distanceFromBottomOfScreen
        player!.zPosition = Player.Constants.zPosition
        player!.alpha = CGFloat(0)
        
        self.addChild(player!)
        
        let initialFadeInAction = SKAction.fadeInWithDuration(Constants.transitionAnimationDuration)
        player!.runAction(initialFadeInAction)
    }
    
    private func initializeHud() {
        if hud == nil {
            hud = Hud(containerSize: self.size)
        }
        hud!.alpha = 0.0
        hud!.position.y = -((self.size.height / 2) - (hud!.size.height / 2))
        hud!.updateHealthBar(healthPercentage: player!.healthPercentage)
        hud!.updateScoreValue(score: player!.score)
        hud!.updateLevelValue(level: currentLevel)
        
        useItemButton = UIButton(frame: CGRectMake(self.size.width - Constants.useItemButtonHorizontalOffset, self.size.height - Constants.useItemButtonVerticalOffset, Constants.useItemButtonWidth, Constants.useItemButtonHeight))
        useItemButton.alpha = 0.0
        useItemButton.setImage(UIImage(named: ImageNames.hudUseItemButton), forState: UIControlState.Normal)
        useItemButton.addTarget(self, action: Selector("useItemButtonPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        
        switchWeaponButton = UIButton(frame: CGRectMake(self.size.width - Constants.switchWeaponButtonHorizontalOffset, self.size.height - Constants.switchWeaponButtonVerticalOffset, Constants.switchWeaponButtonWidth, Constants.switchWeaponButtonHeight))
        switchWeaponButton.alpha = 0.0
        switchWeaponButton.setImage(UIImage(named: ImageNames.hudSwitchWeaponButton), forState: UIControlState.Normal)
        switchWeaponButton.addTarget(self, action: Selector("switchWeaponButtonPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        
        pauseButton = UIButton(frame: CGRectMake(Constants.pauseButtonHorizontalOffset, self.size.height - Constants.pauseButtonVerticalOffset, Constants.pauseButtonWidth, Constants.pauseButtonHeight))
        pauseButton.alpha = 0.0
        pauseButton.setImage(UIImage(named: ImageNames.hudPauseButton), forState: UIControlState.Normal)
        pauseButton.addTarget(self, action: Selector("pauseButtonPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addChild(hud!)
        self.view!.addSubview(useItemButton)
        self.view!.addSubview(switchWeaponButton)
        self.view!.addSubview(pauseButton)
            
        let fadeInAction = SKAction.fadeInWithDuration(Constants.transitionAnimationDuration)
        hud!.runAction(fadeInAction)
        UIView.animateWithDuration(Constants.transitionAnimationDuration) {
            self.useItemButton.alpha = 1.0
            self.switchWeaponButton.alpha = 1.0
            self.pauseButton.alpha = 1.0
        }
    }
    
    func useItemButtonPressed() {
        println("Use Item Button Pressed!")
    }
    
    func switchWeaponButtonPressed() {
        println("Switch Weapon Button Pressed!")
    }
    
    func pauseButtonPressed() {
        paused = !paused
        
        if paused {
            useItemButton.enabled = false
            switchWeaponButton.enabled = false
        } else {
            useItemButton.enabled = true
            switchWeaponButton.enabled = true
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if paused {
            return
        }
        
        if let touch = touches.first as? UITouch {
            let touchLocation = touch.locationInView(self.view)
            
            let hudBoundary = (self.size.height) - hud!.size.height
            
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
        if paused {
            return
        }
        
        if let touch = touches.first as? UITouch {
            if userReady == false && touch.tapCount == 2 {
                beginPlayng()
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
    
    private func beginPlayng() {
        levelLabel!.removeFromParent()
        instructionsLabel!.removeFromParent()
        
        userReady = true
        player!.canShoot = true
        AlienFighter.canSpawn = true
    }
    
    override func update(currentTime: NSTimeInterval) {
        if userReady && paused == false {
            updatePlayer()
            updateProjectiles()
            updateEnemies()
        }
    }
    
    private func updatePlayer() {
        updatePlayerPosition()
        updatePlayerVelocity()
        applyFrictionToPlayer()
    }
    
    private func updatePlayerPosition() {
        player!.position.x += player!.velocity
        if player!.position.x < -((self.size.width / 2) - (player!.size.width / 3)) {
            player!.position.x = -((self.size.width / 2) - (player!.size.width / 3))
        } else if player!.position.x > ((self.size.width / 2) - (player!.size.width / 3)) {
            player!.position.x = ((self.size.width / 2) - (player!.size.width / 3))
        }
    }
    
    private func updatePlayerVelocity() {
        if movingRight {
            player!.velocity += Player.Constants.acceleration
        }
        if movingLeft {
            player!.velocity -= Player.Constants.acceleration
        }
        
        if player!.velocity > Player.Constants.maxSpeed {
            player!.velocity = Player.Constants.maxSpeed
        } else if player!.velocity < -(Player.Constants.maxSpeed) {
            player!.velocity = -(Player.Constants.maxSpeed)
        }
    }
    
    private func applyFrictionToPlayer() {
        if player!.velocity > Player.Constants.friction {
            player!.velocity -= Player.Constants.friction
        } else if player!.velocity < -(Player.Constants.friction) {
            player!.velocity += Player.Constants.friction
        } else {
            player!.velocity = 0
        }
    }
    
    private func updateProjectiles() {
        if player!.canShoot {
            player!.canShoot = false
            
            let laser = Laser(imageNamed: ImageNames.laser, player: player!, containerSize: self.size)
            
            self.addChild(laser)
            
            laser.fire()
            
            let fireRateTimer = NSTimer.scheduledTimerWithTimeInterval(laser.fireRateTimeInterval, target: self,
                selector: Selector("fireRateTimerEnded"), userInfo: nil, repeats: false)
        }
    }
    
    func fireRateTimerEnded() {
        player!.canShoot = true
    }
    
    private func updateEnemies() {
        switch currentPhase {
        case .One:
            updateEnemiesForPhaseOne()
        case .Two:
            break
        case .Three:
            break
        case .Four:
            break
        case .Five:
            break
        }
    }
    
    private func updateEnemiesForPhaseOne() {
        if AlienFighter.canSpawn {
            AlienFighter.canSpawn = false
            
            let alienFighter = AlienFighter(imageNamed: ImageNames.alienFighter, player: player!, containerSize: self.size)
            
            self.addChild(alienFighter)
            
            alienFighter.animate(AlienFighter.AnimationType.Down)
            
            let alienFighterSpawnRateTimer = NSTimer.scheduledTimerWithTimeInterval(alienFighter.spawnRate, target: self,
                selector: Selector("alienFighterSpawnRateTimerEnded"), userInfo: nil, repeats: false)
        }
    }
    
    func alienFighterSpawnRateTimerEnded() {
        AlienFighter.canSpawn = true
    }
    
    private enum Phase {
        case One
        case Two
        case Three
        case Four
        case Five
    }
    
    struct Constants {
        static let transitionAnimationDuration = 0.5
        
        static let useItemButtonWidth: CGFloat = 60.0
        static let useItemButtonHeight: CGFloat = 60.0
        static let useItemButtonHorizontalOffset: CGFloat = 70.0
        static let useItemButtonVerticalOffset: CGFloat = 60.0
        
        static let switchWeaponButtonWidth: CGFloat = 60.0
        static let switchWeaponButtonHeight: CGFloat = 60.0
        static let switchWeaponButtonHorizontalOffset: CGFloat = 145.0
        static let switchWeaponButtonVerticalOffset: CGFloat = 60.0
        
        static let pauseButtonWidth: CGFloat = 80.0
        static let pauseButtonHeight: CGFloat = 30.0
        static let pauseButtonHorizontalOffset: CGFloat = 40.0
        static let pauseButtonVerticalOffset: CGFloat = 38.0
        
        static let levelLabelPosition: CGFloat = 100.0
        static let instructionsLabelPosition: CGFloat = -40.0
    }
}
