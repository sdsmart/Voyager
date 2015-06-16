//
//  LevelScene.swift
//
//  Created by Steve Smart on 6/9/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import UIKit
import SpriteKit

class LevelScene: SKScene {
    
    // MARK: Properties
    var parallaxBackground: ParallaxBackground!
    var hud: Hud!
    var player: Player!
    var currentLevel = 1
    var levelLabel: SKSpriteNode!
    
    private var moveInstructionsLabel: SKSpriteNode?
    private var beginInstructionsLabel: SKSpriteNode?
    
    private var useItemButton: UIButton!
    private var switchWeaponButton: UIButton!
    private var pauseButton: UIButton!
    
    private var pauseMenuDarkening: SKSpriteNode!
    private var resumeButton: UIButton!
    private var saveAndQuitButton: UIButton!
    
    private var gamePaused = false
    private var userReady = false
    
    private var movingRight = false
    private var movingLeft = false
    private var moveRightTouch: UITouch?
    private var moveLeftTouch: UITouch?
    
    private var currentPhase = Phase.One
    
    private var playerFireRateTimer = NSTimer()
    private var alienFighterSpawnRateTimer = NSTimer()
    
    // MARK: Initialization Methods
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
        
        registerAppObservers()
        initializeParallaxBackground()
        initializeOverlayMessages()
        initializePlayer()
        initializeHud()
    }
    
    private func registerAppObservers() {
        var defaultCenter = NSNotificationCenter.defaultCenter()
        
        defaultCenter.addObserver(self, selector: Selector("applicationWillResignActive"), name: UIApplicationWillResignActiveNotification, object: nil)
        
        defaultCenter.addObserver(self, selector: Selector("applicationDidEnterBackground"), name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
        defaultCenter.addObserver(self, selector: Selector("applicationWillEnterForeground"), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    private func initializeParallaxBackground() {
        self.addChild(parallaxBackground)
    }
    
    private func initializeOverlayMessages() {
        levelLabel = SKSpriteNode(imageNamed: ImageNames.levelLabel)

        levelLabel.position.y = Constants.levelLabelPosition
        self.addChild(levelLabel)
        
        if currentLevel == 1 {
            if moveInstructionsLabel == nil {
                moveInstructionsLabel = SKSpriteNode(imageNamed: ImageNames.moveInstructionsLabel)
            }
            moveInstructionsLabel!.position.y = Constants.moveInstructionsLabelPosition
            
            if beginInstructionsLabel == nil {
                beginInstructionsLabel = SKSpriteNode(imageNamed: ImageNames.beginInstructionsLabel)
            }
            beginInstructionsLabel!.position.y = Constants.beginInstructionsLabelPosition
            
            self.addChild(moveInstructionsLabel!)
            self.addChild(beginInstructionsLabel!)
        }
    }
    
    private func initializePlayer() {
        player = Player(imageNamed: ImageNames.player)
        
        player.position.y = -(self.size.height / 2) + Player.Constants.distanceFromBottomOfScreen
        player.zPosition = Player.Constants.zPosition
        player.alpha = CGFloat(0)
        
        self.addChild(player)
        
        let initialFadeInAction = SKAction.fadeInWithDuration(Constants.transitionAnimationDuration)
        player.runAction(initialFadeInAction)
    }
    
    private func initializeHud() {
        hud = Hud(containerSize: self.size)
        
        hud.alpha = 0.0
        hud.position.y = -((self.size.height / 2) - (hud.size.height / 2))
        hud.updateHealthBar(healthPercentage: player.healthPercentage)
        hud.updateScoreValue(score: player.score)
        hud.updateLevelValue(level: currentLevel)
        
        useItemButton = UIButton(frame: CGRectMake(self.size.width - Constants.useItemButtonHorizontalOffset, self.size.height - Constants.useItemButtonVerticalOffset, Constants.useItemButtonWidth, Constants.useItemButtonHeight))
        useItemButton.alpha = 0.0
        useItemButton.setImage(UIImage(named: ImageNames.hudUseItemButton), forState: UIControlState.Normal)
        useItemButton.addTarget(self, action: Selector("useItem"), forControlEvents: UIControlEvents.TouchUpInside)
        useItemButton.enabled = false
        
        switchWeaponButton = UIButton(frame: CGRectMake(self.size.width - Constants.switchWeaponButtonHorizontalOffset, self.size.height - Constants.switchWeaponButtonVerticalOffset, Constants.switchWeaponButtonWidth, Constants.switchWeaponButtonHeight))
        switchWeaponButton.alpha = 0.0
        switchWeaponButton.setImage(UIImage(named: ImageNames.hudSwitchWeaponButton), forState: UIControlState.Normal)
        switchWeaponButton.addTarget(self, action: Selector("switchWeapon"), forControlEvents: UIControlEvents.TouchUpInside)
        switchWeaponButton.enabled = false
        
        pauseButton = UIButton(frame: CGRectMake(Constants.pauseButtonHorizontalOffset, self.size.height - Constants.pauseButtonVerticalOffset, Constants.pauseButtonWidth, Constants.pauseButtonHeight))
        pauseButton.alpha = 0.0
        pauseButton.setImage(UIImage(named: ImageNames.hudPauseButton), forState: UIControlState.Normal)
        pauseButton.addTarget(self, action: Selector("pauseGame"), forControlEvents: UIControlEvents.TouchUpInside)
        pauseButton.enabled = false
        
        self.addChild(hud)
        self.view!.addSubview(useItemButton)
        self.view!.addSubview(switchWeaponButton)
        self.view!.addSubview(pauseButton)
        
        let fadeInAction = SKAction.fadeInWithDuration(Constants.transitionAnimationDuration)
        hud.runAction(fadeInAction)
        UIView.animateWithDuration(Constants.transitionAnimationDuration) {
            self.useItemButton.alpha = 1.0
            self.switchWeaponButton.alpha = 1.0
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
        
        UIView.animateWithDuration(Constants.transitionAnimationDuration) {
            self.resumeButton.alpha = 1.0
            self.saveAndQuitButton.alpha = 1.0
        }
    }
    
    private func deInitializePauseMenu() {
        resumeButton.removeFromSuperview()
        saveAndQuitButton.removeFromSuperview()
        pauseMenuDarkening.removeFromParent()
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
                movingRight = true
                moveRightTouch = touch
            } else if touchLocation.x < (self.size.width / 2) && touchLocation.y <= hudBoundary {
                movingLeft = true
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
                movingRight = false
                moveRightTouch = nil
            } else if touch === moveLeftTouch {
                movingLeft = false
                moveLeftTouch = nil
            }
        }
    }
    
    private func beginPlayng() {
        levelLabel.removeFromParent()
        if currentLevel == 1 {
            moveInstructionsLabel!.removeFromParent()
            beginInstructionsLabel!.removeFromParent()
        }
        
        userReady = true
        player.canShoot = true
        AlienFighter.canSpawn = true
        pauseButton.enabled = true
    }
    
    // MARK: Observer Methods
    func applicationWillResignActive() {
        if gamePaused == false {
            self.paused = true
        }
    }
    
    func applicationDidEnterBackground() {
        self.view!.paused = true
    }
    
    func applicationWillEnterForeground() {
        self.view!.paused = false
        
        if gamePaused {
            self.paused = true
        }
    }
    
    func useItem() {
        println("Use Item Button Pressed!")
    }
    
    func switchWeapon() {
        println("Switch Weapon Button Pressed!")
    }
    
    func pauseGame() {
        gamePaused = true
        self.paused = true
        
        pauseButton.enabled = false
        useItemButton.enabled = false
        switchWeaponButton.enabled = false
        initializePauseMenu()
    }
    
    func resumeGame() {
        gamePaused = false
        self.paused = false
        
        pauseButton.enabled = true
        useItemButton.enabled = true
        switchWeaponButton.enabled = true
        deInitializePauseMenu()
    }
    
    func saveAndQuit() {
        // Save Level Here
        
        pauseButton.removeFromSuperview()
        useItemButton.removeFromSuperview()
        switchWeaponButton.removeFromSuperview()
        resumeButton.removeFromSuperview()
        saveAndQuitButton.removeFromSuperview()
        player.removeFromParent()
        hud.removeFromParent()
        
        let menuScene = MenuScene(size: self.view!.bounds.size)
        menuScene.scaleMode = .AspectFill
        
        parallaxBackground.removeFromParent()
        menuScene.parallaxBackground = parallaxBackground
        
        self.view!.presentScene(menuScene)
    }
    
    func prepareProjectile() {
        if gamePaused {
            playerFireRateTimer.invalidate()
            playerFireRateTimer = NSTimer.scheduledTimerWithTimeInterval(player.fireRateTimeInterval, target: self,
                selector: Selector("prepareProjectile"), userInfo: nil, repeats: false)
        } else {
            player.canShoot = true
        }
    }
    
    func prepareNewAlienFighter() {
        if gamePaused {
            alienFighterSpawnRateTimer.invalidate()
            alienFighterSpawnRateTimer = NSTimer.scheduledTimerWithTimeInterval(AlienFighter.spawnRate, target: self,
                selector: Selector("prepareNewAlienFighter"), userInfo: nil, repeats: false)
        } else {
            AlienFighter.canSpawn = true
        }
    }
    
    // MARK: Update Methods
    override func update(currentTime: NSTimeInterval) {
        if userReady && gamePaused == false {
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
    
    private func updateProjectiles() {
        if player.canShoot {
            player.canShoot = false
            
            let laser = Laser(imageNamed: ImageNames.laser, player: player, containerSize: self.size)
            
            self.addChild(laser)
            
            laser.fire()
            
            let playerFireRateTimer = NSTimer.scheduledTimerWithTimeInterval(player.fireRateTimeInterval, target: self,
                selector: Selector("prepareProjectile"), userInfo: nil, repeats: false)
        }
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
            
            let alienFighter = AlienFighter(imageNamed: ImageNames.alienFighter, player: player, containerSize: self.size)
            
            self.addChild(alienFighter)
            
            alienFighter.animate(AlienFighter.AnimationType.Down)
            
            alienFighterSpawnRateTimer = NSTimer.scheduledTimerWithTimeInterval(AlienFighter.spawnRate, target: self,
                selector: Selector("prepareNewAlienFighter"), userInfo: nil, repeats: false)
        }
    }
    
    // MARK: Enums & Constants
    private enum Phase {
        case One
        case Two
        case Three
        case Four
        case Five
    }
    
    struct Constants {
        static let transitionAnimationDuration = 0.5
        
        static let levelLabelPosition: CGFloat = 115.0
        static let moveInstructionsLabelPosition: CGFloat = -40.0
        static let beginInstructionsLabelPosition: CGFloat = 80.0
        
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
        
        static let resumeButtonWidth: CGFloat = 175.0
        static let resumeButtonHeight: CGFloat = 30.0
        static let resumeButtonVerticalOffset: CGFloat = 75.0
        
        static let saveAndQuitButtonWidth: CGFloat = 275.0
        static let saveAndQuitButtonHeight: CGFloat = 30.0
        static let saveAndQuitButtonVerticalOffset: CGFloat = 0.0
    }
}
