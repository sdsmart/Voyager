//
//  ChooseSpecialScene.swift
//  Voyager
//
//  Created by Steve Smart on 6/20/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class UpgradeScene: SKScene {
    
    // MARK: Properties
    var parallaxBackground: ParallaxBackground!
    var player: Player!
    var background: SKSpriteNode!
    var upgradesHeader: SKSpriteNode!
    var goldHeader: SKSpriteNode!
    var goldValue: SKLabelNode!
    var confirmButton: UIButton!
    var photonCannonHeader: SKSpriteNode!
    var photonCannonSprite: SKSpriteNode!
    var photonCannonLevelHeader: SKSpriteNode!
    var photonCannonLevelValue: SKLabelNode!
    var upgradePhotonCannonButton: UIButton!
    var photonCannonPriceHeader: SKSpriteNode!
    var photonCannonPriceValue: SKLabelNode!
    var selectPhotonCannonButton: UIButton!
    var piercingBeamHeader: SKSpriteNode!
    var piercingBeamSprite: SKSpriteNode!
    var piercingBeamLevelHeader: SKSpriteNode!
    var piercingBeamLevelValue: SKLabelNode!
    var upgradePiercingBeamButton: UIButton!
    var piercingBeamPriceHeader: SKSpriteNode!
    var piercingBeamPriceValue: SKLabelNode!
    var selectPiercingBeamButton: UIButton!
    var clusterShotHeader: SKSpriteNode!
    var clusterShotSprite: SKSpriteNode!
    var clusterShotLevelHeader: SKSpriteNode!
    var clusterShotLevelValue: SKLabelNode!
    var upgradeClusterShotButton: UIButton!
    var clusterShotPriceHeader: SKSpriteNode!
    var clusterShotPriceValue: SKLabelNode!
    var selectClusterShotButton: UIButton!
    
    // Initialization Methods
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.0))
        
        initializeParallaxBackground()
        initializeUIElements()
        initializePlayer()
        updateUIStates()
    }
    
    private func initializeParallaxBackground() {
        self.addChild(parallaxBackground)
    }
    
    private func initializeUIElements() {
        initializeTitleBarElements()
        initializePhotonCannonElements()
        initializePiercingBeamElements()
        initializeClusterShotElements()
        self.view!.addSubview(confirmButton)
    }
    
    private func initializeTitleBarElements() {
        background = SKSpriteNode(imageNamed: ImageNames.upgradesMenuBackground)
        background.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.0))
        
        upgradesHeader = SKSpriteNode(imageNamed: ImageNames.upgradesTitleHeader)
        upgradesHeader.position.y = background.size.height - (upgradesHeader.size.height / 2) - Constants.upgradesHeaderVerticalOffset
        upgradesHeader.position.x = -(self.size.width / 2) + (upgradesHeader.size.width / 2) + Constants.upgradesHeaderHorizontalOffset
        
        goldHeader = SKSpriteNode(imageNamed: ImageNames.upgradesGoldHeader)
        goldHeader.position.y = background.size.height - (goldHeader.size.height / 2) - Constants.goldHeaderVerticalOffset
        goldHeader.position.x = (self.size.width / 2) - (goldHeader.size.width / 2) - Constants.goldHeaderHorizontalOffset
        
        goldValue = SKLabelNode(fontNamed: Constants.fontName)
        goldValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        goldValue.fontSize = Constants.goldValueFontSize
        goldValue.fontColor = Constants.goldValueColor
        goldValue.position.y = background.size.height - Constants.goldValueVerticalOffset
        goldValue.position.x = (self.size.width / 2) - Constants.goldValueHorizontalOffset
        
        self.addChild(background)
        self.addChild(upgradesHeader)
        self.addChild(goldHeader)
        self.addChild(goldValue)
    }
    
    private func initializePhotonCannonElements() {
        photonCannonHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPhotonCannonHeader)
        photonCannonHeader.position.y = background.size.height - (photonCannonHeader.size.height / 2) - Constants.photonCannonHeaderVerticalOffset
        photonCannonHeader.position.x = -(self.size.width / 2) + (photonCannonHeader.size.width / 2) + Constants.photonCannonHeaderHorizontalOffset
        
        photonCannonSprite = SKSpriteNode(imageNamed: ImageNames.photonCannon)
        photonCannonSprite.position.y = background.size.height - (photonCannonSprite.size.height / 2) - Constants.photonCannonSpriteVerticalOffset
        photonCannonSprite.position.x = -(self.size.width / 2) + (photonCannonSprite.size.width / 2) + Constants.photonCannonSpriteHorizontalOffset
        
        photonCannonLevelHeader = SKSpriteNode(imageNamed: ImageNames.upgradesLevelHeader)
        photonCannonLevelHeader.position.y = background.size.height - (photonCannonLevelHeader.size.height / 2) - Constants.photonCannonLevelHeaderVerticalOffset
        photonCannonLevelHeader.position.x = -(self.size.width / 2) + (photonCannonLevelHeader.size.width / 2) + Constants.photonCannonLevelHeaderHorizontalOffset
        
        photonCannonLevelValue = SKLabelNode(fontNamed: Constants.fontName)
        photonCannonLevelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        photonCannonLevelValue.fontSize = Constants.photonCannonLevelValueFontSize
        photonCannonLevelValue.fontColor = Constants.photonCannonLevelValueFontColor
        photonCannonLevelValue.position.y = background.size.height - Constants.photonCannonLevelValueVerticalOffset
        photonCannonLevelValue.position.x = -(self.size.width / 2) + Constants.photonCannonLevelValueHorizontalOffset
        photonCannonLevelValue.text = "\(player.photonCannonLevel)"
        
        upgradePhotonCannonButton = UIButton(frame: CGRectMake(Constants.upgradePhotonCannonButtonHorizontalOffset, (self.size.height - background.size.height + Constants.upgradePhotonCannonButtonVerticalOffset), Constants.upgradePhotonCannonButtonWidth, Constants.upgradePhotonCannonButtonHeight))
        upgradePhotonCannonButton.setImage(UIImage(named: ImageNames.upgradesUpgradeButton), forState: UIControlState.Normal)
        upgradePhotonCannonButton.addTarget(self, action: Selector("upgradePhotonCannon"), forControlEvents: UIControlEvents.TouchUpInside)
        
        photonCannonPriceHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPriceHeader)
        photonCannonPriceHeader.position.y = background.size.height - (photonCannonPriceHeader.size.height / 2) - Constants.photonCannonPriceHeaderVerticalOffset
        photonCannonPriceHeader.position.x = -(self.size.width / 2) + (photonCannonPriceHeader.size.width / 2) + Constants.photonCannonPriceHeaderHorizontalOffset
        
        photonCannonPriceValue = SKLabelNode(fontNamed: Constants.fontName)
        photonCannonPriceValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        photonCannonPriceValue.fontSize = Constants.photonCannonPriceValueFontSize
        photonCannonPriceValue.fontColor = Constants.photonCannonPriceValueFontColor
        photonCannonPriceValue.position.y = background.size.height - Constants.photonCannonPriceValueVerticalOffset
        photonCannonPriceValue.position.x = -(self.size.width / 2) + Constants.photonCannonPriceValueHorizontalOffset
        
        selectPhotonCannonButton = UIButton(frame: CGRectMake(Constants.selectPhotonCannonButtonHorizontalOffset, (self.size.height - background.size.height + Constants.selectPhotonCannonButtonVerticalOffset), Constants.selectPhotonCannonButtonWidth, Constants.selectPhotonCannonButtonHeight))
        selectPhotonCannonButton.setImage(UIImage(named: ImageNames.upgradesSelectButton), forState: UIControlState.Normal)
        selectPhotonCannonButton.addTarget(self, action: Selector("selectPhotonCannon"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addChild(photonCannonHeader)
        self.addChild(photonCannonSprite)
        self.addChild(photonCannonLevelHeader)
        self.addChild(photonCannonLevelValue)
        self.addChild(photonCannonPriceHeader)
        self.addChild(photonCannonPriceValue)
        self.view!.addSubview(upgradePhotonCannonButton)
        self.view!.addSubview(selectPhotonCannonButton)
    }
    
    private func initializePiercingBeamElements() {
        piercingBeamHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPiercingBeamHeader)
        piercingBeamHeader.position.y = background.size.height - (piercingBeamHeader.size.height / 2) - Constants.piercingBeamHeaderVerticalOffset
        
        piercingBeamSprite = SKSpriteNode(imageNamed: ImageNames.piercingBeam)
        piercingBeamSprite.size.height *= 0.5
        piercingBeamSprite.position.y = background.size.height - (piercingBeamSprite.size.height / 2) - Constants.piercingBeamSpriteVerticalOffset
        
        piercingBeamLevelHeader = SKSpriteNode(imageNamed: ImageNames.upgradesLevelHeader)
        piercingBeamLevelHeader.position.y = background.size.height - (piercingBeamLevelHeader.size.height / 2) - Constants.piercingBeamLevelHeaderVerticalOffset
        piercingBeamLevelHeader.position.x = -(Constants.piercingBeamLevelHeaderHorizontalOffset)
        
        piercingBeamLevelValue = SKLabelNode(fontNamed: Constants.fontName)
        piercingBeamLevelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        piercingBeamLevelValue.fontSize = Constants.piercingBeamLevelValueFontSize
        piercingBeamLevelValue.fontColor = Constants.piercingBeamLevelValueFontColor
        piercingBeamLevelValue.position.y = background.size.height - Constants.piercingBeamLevelValueVerticalOffset
        piercingBeamLevelValue.position.x = Constants.piercingBeamLevelValueHorizontalOffset
        piercingBeamLevelValue.text = "\(player.piercingBeamLevel)"
        
        upgradePiercingBeamButton = UIButton(frame: CGRectMake(((self.size.width / 2) - (Constants.upgradePiercingBeamButtonWidth / 2)), self.size.height - background.size.height + Constants.upgradePiercingBeamButtonVerticalOffset, Constants.upgradePiercingBeamButtonWidth, Constants.upgradePiercingBeamButtonHeight))
        upgradePiercingBeamButton.setImage(UIImage(named: ImageNames.upgradesUpgradeButton), forState: UIControlState.Normal)
        upgradePiercingBeamButton.addTarget(self, action: Selector("upgradePiercingBeam"), forControlEvents: UIControlEvents.TouchUpInside)
        
        piercingBeamPriceHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPriceHeader)
        piercingBeamPriceHeader.position.y = background.size.height - (piercingBeamPriceHeader.size.height / 2) - Constants.piercingBeamPriceHeaderVerticalOffset
        piercingBeamPriceHeader.position.x = -(Constants.piercingBeamPriceHeaderHorizontalOffset)
        
        piercingBeamPriceValue = SKLabelNode(fontNamed: Constants.fontName)
        piercingBeamPriceValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        piercingBeamPriceValue.fontSize = Constants.piercingBeamPriceValueFontSize
        piercingBeamPriceValue.fontColor = Constants.piercingBeamPriceValueFontColor
        piercingBeamPriceValue.position.y = background.size.height - Constants.piercingBeamPriceValueVeticalOffset
        piercingBeamPriceValue.position.x = Constants.piercingBeamPriceValueHorizontalOffset
        
        selectPiercingBeamButton = UIButton(frame: CGRectMake(((self.size.width / 2) - (Constants.selectPiercingBeamButtonWidth / 2)), (self.size.height - background.size.height + Constants.selectPiercingBeamButtonVerticalOffset), Constants.selectPiercingBeamButtonWidth, Constants.selectPiercingBeamButtonHeight))
        selectPiercingBeamButton.setImage(UIImage(named: ImageNames.upgradesSelectButton), forState: UIControlState.Normal)
        selectPiercingBeamButton.addTarget(self, action: Selector("selectPiercingBeam"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addChild(piercingBeamHeader)
        self.addChild(piercingBeamSprite)
        self.addChild(piercingBeamLevelHeader)
        self.addChild(piercingBeamLevelValue)
        self.addChild(piercingBeamPriceHeader)
        self.addChild(piercingBeamPriceValue)
        self.view!.addSubview(upgradePiercingBeamButton)
        self.view!.addSubview(selectPiercingBeamButton)
    }
    
    private func initializeClusterShotElements() {
        clusterShotHeader = SKSpriteNode(imageNamed: ImageNames.upgradesClusterShotHeader)
        clusterShotHeader.position.y = background.size.height - (clusterShotHeader.size.height / 2) - Constants.clusterShotHeaderVerticalOffset
        clusterShotHeader.position.x = (self.size.width / 2) - (clusterShotHeader.size.width / 2) - Constants.clusterShotHeaderHorizontalOffset
        
        clusterShotSprite = SKSpriteNode(imageNamed: ImageNames.upgradesClusterShotSprite)
        clusterShotSprite.position.y = background.size.height - (clusterShotSprite.size.height / 2) - Constants.clusterShotSpriteVerticalOffset
        clusterShotSprite.position.x = (self.size.width / 2) - (clusterShotSprite.size.width / 2) - Constants.clusterShotSpriteHorizontalOffset
        
        clusterShotLevelHeader = SKSpriteNode(imageNamed: ImageNames.upgradesLevelHeader)
        clusterShotLevelHeader.position.y = background.size.height - (clusterShotLevelHeader.size.height / 2) - Constants.clusterShotLevelHeaderVerticalOffset
        clusterShotLevelHeader.position.x = (self.size.width / 2) - (clusterShotLevelHeader.size.width / 2) - Constants.clusterShotLevelHeaderHorizontalOffset
        
        clusterShotLevelValue = SKLabelNode(fontNamed: Constants.fontName)
        clusterShotLevelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        clusterShotLevelValue.fontSize = Constants.clusterShotLevelValueFontSize
        clusterShotLevelValue.fontColor = Constants.clusterShotLevelValueFontColor
        clusterShotLevelValue.position.y = background.size.height  - Constants.clusterShotLevelValueVerticalOffset
        clusterShotLevelValue.position.x = (self.size.width / 2) - Constants.clusterShotLevelValueHorizontalOffset
        clusterShotLevelValue.text = "\(player.clusterShotLevel)"
        
        upgradeClusterShotButton = UIButton(frame: CGRectMake((self.size.width - Constants.upgradeClusterShotButtonWidth - Constants.upgradeClusterShotButtonHorizontalOffset), (self.size.height - background.size.height + Constants.upgradeClusterShotButtonVerticalOffset), Constants.upgradeClusterShotButtonWidth, Constants.upgradeClusterShotButtonHeight))
        upgradeClusterShotButton.setImage(UIImage(named: ImageNames.upgradesUpgradeButton), forState: UIControlState.Normal)
        upgradeClusterShotButton.addTarget(self, action: Selector("upgradeClusterShot"), forControlEvents: UIControlEvents.TouchUpInside)
        
        clusterShotPriceHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPriceHeader)
        clusterShotPriceHeader.position.y = background.size.height - (clusterShotPriceHeader.size.height / 2) - Constants.clusterShotPriceHeaderVerticalOffset
        clusterShotPriceHeader.position.x = (self.size.width / 2) - (clusterShotPriceHeader.size.width / 2) - Constants.clusterShotPriceHeaderHorizontalOffset
        
        clusterShotPriceValue = SKLabelNode(fontNamed: Constants.fontName)
        clusterShotPriceValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        clusterShotPriceValue.fontSize = Constants.clusterShotPriceValueFontSize
        clusterShotPriceValue.fontColor = Constants.clusterShotPriceValueFontColor
        clusterShotPriceValue.position.y = background.size.height - Constants.clusterShotPriceValueVerticalOffset
        clusterShotPriceValue.position.x = (self.size.width / 2) - Constants.clusterShotPriceValueHorizontalOffset
        
        selectClusterShotButton = UIButton(frame: CGRectMake((self.size.width - Constants.selectClusterShotButtonHorizontalOffset), (self.size.height - background.size.height + Constants.selectClusterShotButtonVerticalOffset), Constants.selectClusterShotButtonWidth, Constants.selectClusterShotButtonHeight))
        selectClusterShotButton.setImage(UIImage(named: ImageNames.upgradesSelectButton), forState: UIControlState.Normal)
        selectClusterShotButton.addTarget(self, action: Selector("selectClusterShot"), forControlEvents: UIControlEvents.TouchUpInside)
        
        confirmButton = UIButton(frame: CGRectMake(((self.size.width / 2) - (Constants.confirmButtonWidth / 2)), (self.size.height - Constants.confirmButtonVerticalOffset), Constants.confirmButtonWidth, Constants.confirmButtonHeight))
        confirmButton.setImage(UIImage(named: ImageNames.upgradesConfirmButton), forState: UIControlState.Normal)
        confirmButton.addTarget(self, action: Selector("confirmUpgrades"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addChild(clusterShotHeader)
        self.addChild(clusterShotSprite)
        self.addChild(clusterShotLevelHeader)
        self.addChild(clusterShotLevelValue)
        self.addChild(clusterShotPriceHeader)
        self.addChild(clusterShotPriceValue)
        self.view!.addSubview(upgradeClusterShotButton)
        self.view!.addSubview(selectClusterShotButton)
    }
    
    private func initializePlayer() {
        player.position.y = background.size.height + (player.size.height / 2) + Constants.playerVerticalOffset
        
        self.addChild(player)
        
        let initialFadeInAction = SKAction.fadeInWithDuration(GameController.Constants.transitionAnimationDuration)
        player.runAction(initialFadeInAction)
    }
    
    // MARK: Observer Methods
    func upgradePhotonCannon() {
        player.gold -= photonCannonPriceValue.text.toInt()!
        player.photonCannonLevel++
        updateUIStates()
    }
    
    func upgradePiercingBeam() {
        player.gold -= piercingBeamPriceValue.text.toInt()!
        player.piercingBeamLevel++
        updateUIStates()
    }
    
    func upgradeClusterShot() {
        player.gold -= clusterShotPriceValue.text.toInt()!
        player.clusterShotLevel++
        updateUIStates()
    }
    
    func selectPhotonCannon() {
        player.specialAbility = Player.SpecialAbility.PhotonCannon
        updateUIStates()
    }
    
    func selectPiercingBeam() {
        player.specialAbility = Player.SpecialAbility.PiercingBeam
        updateUIStates()
    }
    
    func selectClusterShot() {
        player.specialAbility = Player.SpecialAbility.ClusterShot
        updateUIStates()
    }
    
    func confirmUpgrades() {
        println("Upgrades Confirmed")
    }
    
    // Update Methods
    override func update(currentTime: NSTimeInterval) {
        if player.specialOffCooldown {
            let fireAction = SKAction.moveToY(self.size.height + Constants.distanceToGetOffScreen, duration: 1 / Constants.specialVelocity)
            switch player.specialAbility {
            case .PhotonCannon:
                if player.photonCannonLevel > 0 {
                    player.specialOffCooldown = false
                    let photonCannon = PhotonCannon(player: player, parentScene: self)
                    self.addChild(photonCannon)
                    photonCannon.runAction(fireAction) {
                        self.player.specialOffCooldown = true
                    }
                }
            case .PiercingBeam:
                if player.piercingBeamLevel > 0 {
                    player.specialOffCooldown = false
                    let piercingBeam = PiercingBeam(player: player, parentScene: self)
                    self.addChild(piercingBeam)
                    piercingBeam.runAction(fireAction) {
                        self.player.specialOffCooldown = true
                    }
                }
            case .ClusterShot:
                if player.clusterShotLevel > 0 {
                    player.specialOffCooldown = false
                    let clusterShot = ClusterShot(player: player, parentScene: self)
                    self.addChild(clusterShot)
                    clusterShot.runAction(fireAction) {
                        self.player.specialOffCooldown = true
                    }
                    
                    let clusterShotLeft = ClusterShot(player: player, parentScene: self)
                    let fireLeftAction = SKAction.moveTo(CGPointMake(player.position.x - Constants.clusterShotHorizontalSpreadDistance, self.size.height + Constants.distanceToGetOffScreen), duration: 1 / Constants.specialVelocity)
                    self.addChild(clusterShotLeft)
                    clusterShotLeft.runAction(fireLeftAction)
                    
                    let clusterShotRight = ClusterShot(player: player, parentScene: self)
                    let fireRightAction = SKAction.moveTo(CGPointMake(player.position.x + Constants.clusterShotHorizontalSpreadDistance, self.size.height + Constants.distanceToGetOffScreen), duration: 1 / Constants.specialVelocity)
                    self.addChild(clusterShotRight)
                    clusterShotRight.runAction(fireRightAction)
                }
            case .None:
                break
            }
        }
    }
    
    private func updateUIStates() {
        goldValue.text = "\(player.gold)"
        
        photonCannonLevelValue.text = "\(player.photonCannonLevel)"
        piercingBeamLevelValue.text = "\(player.piercingBeamLevel)"
        clusterShotLevelValue.text = "\(player.clusterShotLevel)"
        
        photonCannonPriceValue.text = "\(calculateUpgradePrice(special: Player.SpecialAbility.PhotonCannon))"
        piercingBeamPriceValue.text = "\(calculateUpgradePrice(special: Player.SpecialAbility.PiercingBeam))"
        clusterShotPriceValue.text = "\(calculateUpgradePrice(special: Player.SpecialAbility.ClusterShot))"
        
        if player.gold < photonCannonPriceValue.text.toInt() {
            upgradePhotonCannonButton.enabled = false
            upgradePhotonCannonButton.alpha = 0.5
        }
        if player.gold < piercingBeamPriceValue.text.toInt() {
            upgradePiercingBeamButton.enabled = false
            upgradePiercingBeamButton.alpha = 0.5
        }
        if player.gold < clusterShotPriceValue.text.toInt() {
            upgradeClusterShotButton.enabled = false
            upgradeClusterShotButton.alpha = 0.5
        }
        
        if player.photonCannonLevel > 0 && player.specialAbility != Player.SpecialAbility.PhotonCannon {
            selectPhotonCannonButton.enabled = true
            selectPhotonCannonButton.alpha = 1.0
        } else {
            selectPhotonCannonButton.enabled = false
            selectPhotonCannonButton.alpha = 0.5
        }
        if player.piercingBeamLevel > 0 && player.specialAbility != Player.SpecialAbility.PiercingBeam {
            selectPiercingBeamButton.enabled = true
            selectPiercingBeamButton.alpha = 1.0
        } else {
            selectPiercingBeamButton.enabled = false
            selectPiercingBeamButton.alpha = 0.5
        }
        if player.clusterShotLevel > 0 && player.specialAbility != Player.SpecialAbility.ClusterShot {
            selectClusterShotButton.enabled = true
            selectClusterShotButton.alpha = 1.0
        } else {
            selectClusterShotButton.enabled = false
            selectClusterShotButton.alpha = 0.5
        }
        
        if player.specialAbility == Player.SpecialAbility.None {
            confirmButton.hidden = true
        } else {
            confirmButton.hidden = false
        }
    }
    
    private func calculateUpgradePrice(#special: Player.SpecialAbility) -> Int {
        switch special {
        case .PhotonCannon:
            var result = Double(PhotonCannon.Constants.baseUpgradeCost)
            result += result * PhotonCannon.Constants.upgradeIncrementRatio * Double(player.photonCannonLevel)
            return Int(result)
        case .PiercingBeam:
            var result = Double(PiercingBeam.Constants.baseUpgradeCost)
            result += result * PiercingBeam.Constants.upgradeIncrementRatio * Double(player.piercingBeamLevel)
            return Int(result)
        case .ClusterShot:
            var result = Double(ClusterShot.Constants.baseUpgradeCost)
            result += result * ClusterShot.Constants.upgradeIncrementRatio * Double(player.clusterShotLevel)
            return Int(result)
        case .None:
            return 0
        }
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let fontName = "HelveticaNeue-Medium"
        static let playerVerticalOffset: CGFloat = 25.0
        static let upgradesHeaderVerticalOffset: CGFloat = 10.0
        static let upgradesHeaderHorizontalOffset: CGFloat = 10.0
        static let goldHeaderVerticalOffset: CGFloat = 13.0
        static let goldHeaderHorizontalOffset: CGFloat = 58.0
        static let goldValueVerticalOffset: CGFloat = 27.0
        static let goldValueHorizontalOffset: CGFloat = 56.0
        static let goldValueFontSize: CGFloat = 16.0
        static let goldValueColor = UIColor(red: 255/255, green: 185/255, blue: 0, alpha: 1.0)
        static let photonCannonHeaderVerticalOffset: CGFloat = 49.0
        static let photonCannonHeaderHorizontalOffset: CGFloat = 34.0
        static let photonCannonSpriteVerticalOffset: CGFloat = 76.0
        static let photonCannonSpriteHorizontalOffset: CGFloat = 42.0
        static let photonCannonLevelHeaderVerticalOffset: CGFloat = 121.0
        static let photonCannonLevelHeaderHorizontalOffset: CGFloat = 33.0
        static let photonCannonLevelValueVerticalOffset: CGFloat = 130.0
        static let photonCannonLevelValueHorizontalOffset: CGFloat = 74.0
        static let photonCannonLevelValueFontSize: CGFloat = 12.0
        static let photonCannonLevelValueFontColor = UIColor(red: 0, green: 215/255, blue: 0, alpha: 1.0)
        static let upgradePhotonCannonButtonVerticalOffset: CGFloat = 140.0
        static let upgradePhotonCannonButtonHorizontalOffset: CGFloat = 13.0
        static let upgradePhotonCannonButtonWidth: CGFloat = 90.0
        static let upgradePhotonCannonButtonHeight: CGFloat = 30.0
        static let photonCannonPriceHeaderVerticalOffset: CGFloat = 180.0
        static let photonCannonPriceHeaderHorizontalOffset: CGFloat = 24.0
        static let photonCannonPriceValueFontSize: CGFloat = 12.0
        static let photonCannonPriceValueFontColor = UIColor(red: 255/255, green: 185/255, blue: 0, alpha: 1.0)
        static let photonCannonPriceValueVerticalOffset: CGFloat = 189.0
        static let photonCannonPriceValueHorizontalOffset: CGFloat = 65.0
        static let selectPhotonCannonButtonVerticalOffset: CGFloat = 198.0
        static let selectPhotonCannonButtonHorizontalOffset: CGFloat = 13.0
        static let selectPhotonCannonButtonWidth: CGFloat = 90.0
        static let selectPhotonCannonButtonHeight: CGFloat = 30.0
        static let piercingBeamHeaderVerticalOffset: CGFloat = 49.0
        static let piercingBeamSpriteVerticalOffset: CGFloat = 76.0
        static let piercingBeamLevelHeaderVerticalOffset: CGFloat = 121.0
        static let piercingBeamLevelHeaderHorizontalOffset: CGFloat = 8.0
        static let piercingBeamLevelValueVerticalOffset: CGFloat = 130.0
        static let piercingBeamLevelValueHorizontalOffset: CGFloat = 13.0
        static let piercingBeamLevelValueFontSize: CGFloat = 12.0
        static let piercingBeamLevelValueFontColor = UIColor(red: 0, green: 215/255, blue: 0, alpha: 1.0)
        static let upgradePiercingBeamButtonVerticalOffset: CGFloat = 140.0
        static let upgradePiercingBeamButtonWidth: CGFloat = 90.0
        static let upgradePiercingBeamButtonHeight: CGFloat = 30.0
        static let piercingBeamPriceHeaderVerticalOffset: CGFloat = 180.0
        static let piercingBeamPriceHeaderHorizontalOffset: CGFloat = 14.0
        static let piercingBeamPriceValueFontSize: CGFloat = 12.0
        static let piercingBeamPriceValueFontColor = UIColor(red: 255/255, green: 185/255, blue: 0, alpha: 1.0)
        static let piercingBeamPriceValueVeticalOffset: CGFloat = 189.0
        static let piercingBeamPriceValueHorizontalOffset: CGFloat = 7.0
        static let selectPiercingBeamButtonVerticalOffset: CGFloat = 198.0
        static let selectPiercingBeamButtonWidth: CGFloat = 90.0
        static let selectPiercingBeamButtonHeight: CGFloat = 30.0
        static let clusterShotHeaderVerticalOffset: CGFloat = 49.0
        static let clusterShotHeaderHorizontalOffset: CGFloat = 28.0
        static let clusterShotSpriteVerticalOffset: CGFloat = 77.0
        static let clusterShotSpriteHorizontalOffset: CGFloat = 42.0
        static let clusterShotLevelHeaderVerticalOffset: CGFloat = 121.0
        static let clusterShotLevelHeaderHorizontalOffset: CGFloat = 44.0
        static let clusterShotLevelValueVerticalOffset: CGFloat = 130.0
        static let clusterShotLevelValueHorizontalOffset: CGFloat = 43.0
        static let clusterShotLevelValueFontSize: CGFloat = 12.0
        static let clusterShotLevelValueFontColor = UIColor(red: 0, green: 215/255, blue: 0, alpha: 1.0)
        static let upgradeClusterShotButtonVerticalOffset: CGFloat = 140.0
        static let upgradeClusterShotButtonHorizontalOffset: CGFloat = 13.0
        static let upgradeClusterShotButtonWidth: CGFloat = 90.0
        static let upgradeClusterShotButtonHeight: CGFloat = 30.0
        static let clusterShotPriceHeaderVerticalOffset: CGFloat = 180.0
        static let clusterShotPriceHeaderHorizontalOffset: CGFloat = 52.0
        static let clusterShotPriceValueFontSize: CGFloat = 12.0
        static let clusterShotPriceValueFontColor = UIColor(red: 255/255, green: 185/255, blue: 0, alpha: 1.0)
        static let clusterShotPriceValueVerticalOffset: CGFloat = 189.0
        static let clusterShotPriceValueHorizontalOffset: CGFloat = 51.0
        static let selectClusterShotButtonVerticalOffset: CGFloat = 198.0
        static let selectClusterShotButtonHorizontalOffset: CGFloat = 103.0
        static let selectClusterShotButtonWidth: CGFloat = 90.0
        static let selectClusterShotButtonHeight: CGFloat = 30.0
        static let confirmButtonVerticalOffset: CGFloat = 60.0
        static let confirmButtonWidth: CGFloat = 150.0
        static let confirmButtonHeight: CGFloat = 40.0
        static let distanceToGetOffScreen: CGFloat = 300.0
        static let specialVelocity = 1.0
        static let clusterShotHorizontalSpreadDistance: CGFloat = 100.0
    }
}