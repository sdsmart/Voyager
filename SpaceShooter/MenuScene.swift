//
//  GameScene.swift
//  SpaceShooter
//
//  Created by Steve Smart on 6/6/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    var parallaxBackground: ParallaxBackground!
    
    var playButton: UIButton!
    var highscoresButton: UIButton!
    var optionsButton: UIButton!
    
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
        
        initializeParallaxBackground()
        initializeMenuButtons()
    }
    
    private func initializeParallaxBackground()
    {
        parallaxBackground = ParallaxBackground(imageNames: ImageNames.backgroundImageNames, baseScrollDuration: ParallaxBackground.Constants.baseScrollDuration, scrollDurationChangeRatio: ParallaxBackground.Constants.ScrollDurationChangeRatio, containerHeight: self.size.height, numberOfTiles: ParallaxBackground.Constants.numberOfTiles, scrollDown: true)
        parallaxBackground.beginScrolling()
        
        if parallaxBackground.backgrounds != nil {
            for bg in parallaxBackground.backgrounds! {
                self.addChild(bg)
            }
        }
    }
    
    private func initializeMenuButtons()
    {
        let playButtonFrame = CGRectMake(((self.size.width / 2) - (MenuScene.Constants.playButtonWidth / 2)), (((self.size.height / 2) - (MenuScene.Constants.playButtonHeight / 2)) + MenuScene.Constants.playButtonVerticalOffset), MenuScene.Constants.playButtonWidth, MenuScene.Constants.playButtonHeight)
        playButton = UIButton(frame: playButtonFrame)
        playButton.setImage(UIImage(named: ImageNames.playButtonImageName), forState: UIControlState.Normal)
        playButton.addTarget(self, action: Selector("playButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let highscoresButtonFrame = CGRectMake(((self.size.width / 2) - (MenuScene.Constants.highscoresButtonWidth / 2)), ((self.size.height / 2) - (MenuScene.Constants.highscoresButtonHeight / 2)), MenuScene.Constants.highscoresButtonWidth, MenuScene.Constants.highscoresButtonHeight)
        highscoresButton = UIButton(frame: highscoresButtonFrame)
        highscoresButton.setImage(UIImage(named: ImageNames.highscoresButtonImageName), forState: UIControlState.Normal)
        highscoresButton.addTarget(self, action: Selector("highscoresButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let optionsButtonFrame = CGRectMake(((self.size.width / 2) - (MenuScene.Constants.optionsButtonWidth / 2)), (((self.size.height / 2) - (MenuScene.Constants.optionsButtonHeight / 2)) + MenuScene.Constants.optionsButtonVerticalOffset), MenuScene.Constants.optionsButtonWidth, MenuScene.Constants.optionsButtonHeight)
        optionsButton = UIButton(frame: optionsButtonFrame)
        optionsButton.setImage(UIImage(named: ImageNames.optionsButtonImageName), forState: UIControlState.Normal)
        optionsButton.addTarget(self, action: Selector("optionsButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view!.addSubview(playButton)
        self.view!.addSubview(highscoresButton)
        self.view!.addSubview(optionsButton)
    }
    
    func playButtonPressed(sender: UIButton) {
        playButton.removeFromSuperview()
        highscoresButton.removeFromSuperview()
        optionsButton.removeFromSuperview()
        
        let levelScene = LevelScene(size: self.size)
        levelScene.scaleMode = .AspectFill
        
        for bg in parallaxBackground.backgrounds! {
            bg.removeFromParent()
        }
        levelScene.parallaxBackground = parallaxBackground
        
        self.view!.presentScene(levelScene)
    }
    
    func highscoresButtonPressed(sender: UIButton) {
        println("highscores button pressed")
    }
    
    func optionsButtonPressed(sender: UIButton) {
        println("options button pressed")
    }
    
    struct Constants {
        static let transitionAnimationDuration = 0.5
        
        static let playButtonWidth: CGFloat = 150.0
        static let playButtonHeight: CGFloat = 25.0
        static let playButtonVerticalOffset: CGFloat = -75.0
        
        static let highscoresButtonWidth: CGFloat = 250.0
        static let highscoresButtonHeight: CGFloat = 25.0
        
        static let optionsButtonWidth: CGFloat = 200.0
        static let optionsButtonHeight: CGFloat = 25.0
        static let optionsButtonVerticalOffset: CGFloat = 75.0
    }
}