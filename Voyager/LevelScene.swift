//
//  LevelScene.swift
//
//  Created by Steve Smart on 6/9/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class LevelScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: Properties
    var parallaxBackground: ParallaxBackground!
    var hud: Hud!
    var player: Player!
    var levelHandler: LevelHandler!
    var gamePaused = false
    
    private var pauseButton: UIButton!
    private var pauseMenuDarkening: SKSpriteNode!
    private var resumeButton: UIButton!
    private var saveAndQuitButton: UIButton!
    private var userReady = false
    private var moveRightTouch: UITouch?
    private var moveLeftTouch: UITouch?
    
    // MARK: Initialization Methods
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
        self.physicsWorld.contactDelegate = self
        
        registerAppObservers()
        initializePlayer()
        initializeLevelHandler()
        initializeParallaxBackground()
        initializeOverlayMessages()
        initializeHud()
    }
    
    private func registerAppObservers() {
        var defaultCenter = NSNotificationCenter.defaultCenter()
        
        defaultCenter.addObserver(self, selector: Selector("applicationWillResignActive"), name: UIApplicationWillResignActiveNotification, object: nil)
        
        defaultCenter.addObserver(self, selector: Selector("applicationDidEnterBackground"), name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
        defaultCenter.addObserver(self, selector: Selector("applicationWillEnterForeground"), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    private func initializePlayer() {
        player.position.y = -(self.size.height / 2) + Constants.playerDistanceFromBottomOfScreen
        
        self.addChild(player)
        
        let initialFadeInAction = SKAction.fadeInWithDuration(GameController.Constants.transitionAnimationDuration)
        player.runAction(initialFadeInAction)
    }
    
    private func initializeLevelHandler() {
        levelHandler.initialize()
    }
    
    private func initializeParallaxBackground() {
        self.addChild(parallaxBackground)
    }
    
    private func initializeOverlayMessages() {
        levelHandler.showLabel()
    }
    
    private func initializeHud() {
        hud = Hud(parentScene: self)
        hud.updateHealthBar(health: player.health)
        hud.updateGoldValue(gold: player.gold)
        hud.updateLevelValue(level: levelHandler.currentLevel)
        
        pauseButton = UIButton(frame: CGRectMake((self.size.width - Constants.pauseButtonWidth - Constants.pauseButtonHorizontalOffset), (self.size.height - Constants.pauseButtonHeight - Constants.pauseButtonVerticalOffset), Constants.pauseButtonWidth, Constants.pauseButtonHeight))
        pauseButton.alpha = 0.0
        pauseButton.setImage(UIImage(named: ImageNames.hudPauseButton), forState: UIControlState.Normal)
        pauseButton.addTarget(self, action: Selector("pauseGame"), forControlEvents: UIControlEvents.TouchUpInside)
        pauseButton.enabled = false
        
        self.addChild(hud)
        self.view!.addSubview(pauseButton)
        
        let fadeInAction = SKAction.fadeInWithDuration(GameController.Constants.transitionAnimationDuration)
        hud.runAction(fadeInAction)
        UIView.animateWithDuration(GameController.Constants.transitionAnimationDuration) {
            self.pauseButton.alpha = 1.0
        }
    }
    
    private func initializePauseMenu() {
        pauseMenuDarkening = SKSpriteNode(imageNamed: ImageNames.pauseMenuDarkening)
        pauseMenuDarkening.zPosition = 100
        
        resumeButton = UIButton(frame: CGRectMake((self.size.width / 2) - (Constants.resumeButtonWidth / 2), (self.size.height / 2) - Constants.resumeButtonVerticalOffset, Constants.resumeButtonWidth, Constants.resumeButtonHeight))
        resumeButton.alpha = 0.0
        resumeButton.setImage(UIImage(named: ImageNames.resumeButton), forState: UIControlState.Normal)
        resumeButton.addTarget(self, action: Selector("resumeGame"), forControlEvents: UIControlEvents.TouchUpInside)
        
        saveAndQuitButton = UIButton(frame: CGRectMake((self.size.width / 2) - (Constants.saveAndQuitButtonWidth / 2), (self.size.height / 2) + Constants.saveAndQuitButtonVerticalOffset, Constants.saveAndQuitButtonWidth, Constants.saveAndQuitButtonHeight))
        saveAndQuitButton.alpha = 0.0
        saveAndQuitButton.setImage(UIImage(named: ImageNames.saveAndQuitButton), forState: UIControlState.Normal)
        saveAndQuitButton.addTarget(self, action: Selector("saveAndQuit"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addChild(pauseMenuDarkening)
        self.view!.addSubview(resumeButton)
        self.view!.addSubview(saveAndQuitButton)
        
        UIView.animateWithDuration(GameController.Constants.transitionAnimationDuration) {
            self.resumeButton.alpha = 1.0
            self.saveAndQuitButton.alpha = 1.0
        }
    }
    
    private func deInitializePauseMenu() {
        resumeButton.removeFromSuperview()
        saveAndQuitButton.removeFromSuperview()
        pauseMenuDarkening.removeFromParent()
    }
    
    // MARK: Update Methods
    override func update(currentTime: NSTimeInterval) {
        if userReady && gamePaused == false {
            player.update()
            levelHandler.update()
        }
    }
    
    // MARK: UIResponder Methods
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if gamePaused {
            return
        }
        
        if let touch = touches.first as? UITouch {
            let touchLocation = touch.locationInView(self.view)
            
            let hudBoundary = (self.size.height) - hud.size.height
            
            if touchLocation.x >= (self.size.width / 2) && touchLocation.y <= hudBoundary {
                player.movingRight = true
                moveRightTouch = touch
            } else if touchLocation.x < (self.size.width / 2) && touchLocation.y <= hudBoundary {
                player.movingLeft = true
                moveLeftTouch = touch
            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if gamePaused {
            return
        }
        
        if let touch = touches.first as? UITouch {
            if userReady == false && touch.tapCount == 2 {
                beginPlayng()
            }
            
            if touch === moveRightTouch {
                player.movingRight = false
                moveRightTouch = nil
            } else if touch === moveLeftTouch {
                player.movingLeft = false
                moveLeftTouch = nil
            }
        }
    }
    
    private func beginPlayng() {
        levelHandler.hideLabel()
        
        userReady = true
        player.enabled = true
        levelHandler.enabled = true
        pauseButton.enabled = true
    }
    
    // MARK: Collision Detection Methods
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & Laser.Constants.categoryBitmask) != 0 && (secondBody.categoryBitMask & AlienFighter.Constants.categoryBitmask) != 0 {
            
            handleLaserAlienFighterCollision(laser: firstBody, alienFighter: secondBody)
            
        } else if (firstBody.categoryBitMask & AlienFighter.Constants.categoryBitmask) != 0 && (secondBody.categoryBitMask & Laser.Constants.categoryBitmask) != 0 {
            
            handleLaserAlienFighterCollision(laser: secondBody, alienFighter: firstBody)
            
        } else if (firstBody.categoryBitMask & Player.Constants.categoryBitmask) != 0 && (secondBody.categoryBitMask & AlienFighter.Constants.categoryBitmask) != 0 {
            
            handlePlayerAlienFighterCollision(player: firstBody, alienFighter: secondBody)
            
        } else if (firstBody.categoryBitMask & AlienFighter.Constants.categoryBitmask) != 0 && (secondBody.categoryBitMask & Player.Constants.categoryBitmask) != 0 {
            
            handlePlayerAlienFighterCollision(player: secondBody, alienFighter: firstBody)
            
        } else if (firstBody.categoryBitMask & PhotonCannon.Constants.categoryBitmask) != 0 && (secondBody.categoryBitMask & AlienFighter.Constants.categoryBitmask) != 0 {
            
            handlePhotonCannonAlienFighterCollision(photonCannon: firstBody, alienFighter: secondBody)
            
        } else if (firstBody.categoryBitMask & AlienFighter.Constants.categoryBitmask) != 0 && (secondBody.categoryBitMask & PhotonCannon.Constants.categoryBitmask) != 0 {
            
            handlePhotonCannonAlienFighterCollision(photonCannon: secondBody, alienFighter: firstBody)
            
        } else if (firstBody.categoryBitMask & PiercingBeam.Constants.categoryBitmask) != 0 && (secondBody.categoryBitMask & AlienFighter.Constants.categoryBitmask) != 0 {
            
            handlePiercingBeamAlienFighterCollision(piercingBeam: firstBody, alienFighter: secondBody)
            
        } else if (firstBody.categoryBitMask & AlienFighter.Constants.categoryBitmask) != 0 && (secondBody.categoryBitMask & PiercingBeam.Constants.categoryBitmask) != 0 {
            
            handlePiercingBeamAlienFighterCollision(piercingBeam: secondBody, alienFighter: firstBody)
            
        } else if (firstBody.categoryBitMask & ClusterShot.Constants.categoryBitmask) != 0 && (secondBody.categoryBitMask & AlienFighter.Constants.categoryBitmask) != 0 {
            
            handleClusterShotAlienFighterCollision(clusterShot: firstBody, alienFighter: secondBody)
            
        } else if (firstBody.categoryBitMask & AlienFighter.Constants.categoryBitmask) != 0 && (secondBody.categoryBitMask & ClusterShot.Constants.categoryBitmask) != 0 {
            
            handleClusterShotAlienFighterCollision(clusterShot: secondBody, alienFighter: firstBody)
        }
    }
    
    private func handleLaserAlienFighterCollision(#laser: SKPhysicsBody, alienFighter: SKPhysicsBody) {
        if let laserNode = laser.node as? Laser {
            laserNode.removeFromParent()
            
            if let alienFighterNode = alienFighter.node as? AlienFighter {
                alienFighterNode.applyDamage(damage: laserNode.damage)
            }
        }
    }
    
    private func handlePlayerAlienFighterCollision(#player: SKPhysicsBody, alienFighter: SKPhysicsBody) {
        if let playerNode = player.node as? Player {
            playerNode.applyDamage(AlienFighter.Constants.damage)
            hud.updateHealthBar(health: playerNode.health)
            
            if let alienFighterNode = alienFighter.node as? AlienFighter {
                alienFighterNode.removeFromParent()
            }
        }
    }
    
    private func handlePhotonCannonAlienFighterCollision(#photonCannon: SKPhysicsBody, alienFighter: SKPhysicsBody) {
        if let photonCannonNode = photonCannon.node as? PhotonCannon {
            photonCannonNode.removeFromParent()
            
            if let alienFighterNode = alienFighter.node as? AlienFighter {
                alienFighterNode.applyDamage(damage: photonCannonNode.damage)
            }
        }
    }
        
    private func handlePiercingBeamAlienFighterCollision(#piercingBeam: SKPhysicsBody, alienFighter: SKPhysicsBody) {
        if let piercingBeamNode = piercingBeam.node as? PiercingBeam {
            piercingBeamNode.reducePiercingPower()
            
            if let alienFighterNode = alienFighter.node as? AlienFighter {
                if alienFighterNode.hasBeenHitWithPiercingBeam == false {
                    alienFighterNode.applyDamage(damage: piercingBeamNode.damage)
                    alienFighterNode.hasBeenHitWithPiercingBeam = true
                }
            }
        }
    }
    
    private func handleClusterShotAlienFighterCollision(#clusterShot: SKPhysicsBody, alienFighter: SKPhysicsBody) {
        if let clusterShotNode = clusterShot.node as? ClusterShot {
            clusterShotNode.removeFromParent()
            
            if let alienFighterNode = alienFighter.node as? AlienFighter {
                alienFighterNode.applyDamage(damage: clusterShotNode.damage)
            }
        }
    }
    
    // MARK: Observer Methods
    func applicationWillResignActive() {
        if gamePaused == false {
            self.paused = true
        }
    }
    
    func applicationDidEnterBackground() {
        self.view!.paused = true
        SaveState.saveData(level: levelHandler.currentLevel)
    }
    
    func applicationWillEnterForeground() {
        self.view!.paused = false
        
        if gamePaused {
            self.paused = true
        }
    }
    
    func pauseGame() {
        gamePaused = true
        self.paused = true
        
        pauseButton.enabled = false
        initializePauseMenu()
    }
    
    func resumeGame() {
        gamePaused = false
        self.paused = false
        
        pauseButton.enabled = true
        
        deInitializePauseMenu()
    }
    
    func saveAndQuit() {
        SaveState.saveData(level: levelHandler.currentLevel)
        
        pauseButton.removeFromSuperview()
        resumeButton.removeFromSuperview()
        saveAndQuitButton.removeFromSuperview()
        player.removeFromParent()
        hud.removeFromParent()
        levelHandler = nil
        gamePaused = false
        
        let menuScene = MenuScene(size: self.view!.bounds.size)
        menuScene.scaleMode = .AspectFill
        
        parallaxBackground.removeFromParent()
        menuScene.parallaxBackground = parallaxBackground
        
        self.view!.presentScene(menuScene)
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let pauseButtonWidth: CGFloat = 85.0
        static let pauseButtonHeight: CGFloat = 27.0
        static let pauseButtonHorizontalOffset: CGFloat = 7.0
        static let pauseButtonVerticalOffset: CGFloat = 4.0
        static let resumeButtonWidth: CGFloat = 175.0
        static let resumeButtonHeight: CGFloat = 30.0
        static let resumeButtonVerticalOffset: CGFloat = 75.0
        static let saveAndQuitButtonWidth: CGFloat = 275.0
        static let saveAndQuitButtonHeight: CGFloat = 30.0
        static let saveAndQuitButtonVerticalOffset: CGFloat = 0.0
        static let playerDistanceFromBottomOfScreen: CGFloat = 165.0
    }
}
