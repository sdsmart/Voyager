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
        parallaxBackground = ParallaxBackground(imageNames: BackgroundConstants.imageNames, baseScrollDuration: BackgroundConstants.baseScrollDuration, scrollDurationChangeRatio: BackgroundConstants.ScrollDurationChangeRatio, containerHeight: self.size.height, numberOfTiles: BackgroundConstants.numberOfTiles, scrollDown: true)
        parallaxBackground.beginScrolling()
        
        if parallaxBackground.backgrounds != nil {
            for bg in parallaxBackground.backgrounds! {
                self.addChild(bg)
            }
        }
    }
    
    private func initializeMenuButtons()
    {
        let playButtonFrame = CGRectMake(((self.size.width / 2) - (ButtonConstants.playButtonWidth / 2)), (((self.size.height / 2) - (ButtonConstants.playButtonHeight / 2)) + ButtonConstants.playButtonVerticalOffset), ButtonConstants.playButtonWidth, ButtonConstants.playButtonHeight)
        playButton = UIButton(frame: playButtonFrame)
        playButton.setImage(UIImage(named: ButtonConstants.playButtonImageName), forState: UIControlState.Normal)
        playButton.addTarget(self, action: Selector(ButtonConstants.playButtonActionName), forControlEvents: UIControlEvents.TouchUpInside)
        
        let highscoresButtonFrame = CGRectMake(((self.size.width / 2) - (ButtonConstants.highscoresButtonWidth / 2)), ((self.size.height / 2) - (ButtonConstants.highscoresButtonHeight / 2)), ButtonConstants.highscoresButtonWidth, ButtonConstants.highscoresButtonHeight)
        highscoresButton = UIButton(frame: highscoresButtonFrame)
        highscoresButton.setImage(UIImage(named: ButtonConstants.highscoresButtonImageName), forState: UIControlState.Normal)
        highscoresButton.addTarget(self, action: Selector(ButtonConstants.highscoresButtonActionName), forControlEvents: UIControlEvents.TouchUpInside)
        
        let optionsButtonFrame = CGRectMake(((self.size.width / 2) - (ButtonConstants.optionsButtonWidth / 2)), (((self.size.height / 2) - (ButtonConstants.optionsButtonHeight / 2)) + ButtonConstants.optionsButtonVerticalOffset), ButtonConstants.optionsButtonWidth, ButtonConstants.optionsButtonHeight)
        optionsButton = UIButton(frame: optionsButtonFrame)
        optionsButton.setImage(UIImage(named: ButtonConstants.optionsButtonImageName), forState: UIControlState.Normal)
        optionsButton.addTarget(self, action: Selector(ButtonConstants.optionsButtonActionName), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view!.addSubview(playButton)
        self.view!.addSubview(highscoresButton)
        self.view!.addSubview(optionsButton)
    }
    
    func playButtonPressed(sender: UIButton) {
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { self.playButton.alpha = 0 }, completion: nil)
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { self.highscoresButton.alpha = 0 }, completion: nil)
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { self.optionsButton.alpha = 0 }, completion: nil)
        
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
    
    private struct BackgroundConstants {
        static let imageNames = ["menu_background_1",
                                 "menu_background_2",
                                 "menu_background_3"]
        static let baseScrollDuration = 40.0
        static let ScrollDurationChangeRatio = 0.30
        static let numberOfTiles = 3
    }
    
    private struct ButtonConstants {
        static let playButtonImageName = "play-button"
        static let playButtonActionName = "playButtonPressed:"
        static let playButtonWidth: CGFloat = 150.0
        static let playButtonHeight: CGFloat = 25.0
        static let playButtonVerticalOffset: CGFloat = -75.0
        
        static let highscoresButtonImageName = "highscores-button"
        static let highscoresButtonActionName = "highscoresButtonPressed:"
        static let highscoresButtonWidth: CGFloat = 250.0
        static let highscoresButtonHeight: CGFloat = 25.0
        
        static let optionsButtonImageName = "options-button"
        static let optionsButtonActionName = "optionsButtonPressed:"
        static let optionsButtonWidth: CGFloat = 200.0
        static let optionsButtonHeight: CGFloat = 25.0
        static let optionsButtonVerticalOffset: CGFloat = 75.0
    }
}