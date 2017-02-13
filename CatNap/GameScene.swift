//
//  GameScene.swift
//  CatNap
//
//  Created by Patrick Bellot on 1/30/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol EventListnerNode {
	func didMoveToScene()
}

protocol InteractiveNode {
	func interact()
}

struct PhysicsCategory {
	static let None: UInt32 = 0
	static let Cat: UInt32 = 0b1
	static let Block: UInt32 = 0b10
	static let Bed: UInt32 = 0b100
	static let Edge: UInt32 = 0b1000
	static let Label: UInt32 = 0b10000
	static let Spring: UInt32 = 0b100000
	static let Hook: UInt32 = 0b1000000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var bedNode: BedNode!
	var catNode: CatNode!
	var playable = true
	var currentLevel: Int = 0
	
	class func level(levelNum: Int) -> GameScene? {
		let scene = GameScene(fileNamed: "Level\(levelNum)")!
		scene.currentLevel = levelNum
		scene.scaleMode = .aspectFill
		return scene
	}
    
	override func didMove(to view: SKView) {
		
		SKTAudio.sharedInstance()
			.playBackgroundMusic("backgroundMusic.mp3")
		
		// Calculate playable margin
		
		let maxAspectRatio: CGFloat = 16.0/9.0
		let maxAspectRatioHeight = size.width / maxAspectRatio
		let playableMargin: CGFloat = (size.height - maxAspectRatioHeight) / 2
		let playableRect = CGRect(x: 0, y: playableMargin,
		                          width: size.width, height: size.height - playableMargin*2)
		
		physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
		physicsWorld.contactDelegate = self
		physicsBody!.categoryBitMask = PhysicsCategory.Edge
		
		enumerateChildNodes(withName: "//*", using: { node, _ in
			if let eventListnerNode = node as? EventListnerNode {
				eventListnerNode.didMoveToScene()
			}
		})
		
		bedNode = childNode(withName: "bed") as! BedNode
		catNode = childNode(withName: "//cat_body") as! CatNode
		
//		let rotationConstraint = SKConstraint.zRotation(
//			SKRange(lowerLimit: -π/4, upperLimit: π/4))
//		catNode.parent!.constraints = [rotationConstraint]
		
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
		
		let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
		
		if collision == PhysicsCategory.Label | PhysicsCategory.Edge {
			let labelNode = contact.bodyA.categoryBitMask == PhysicsCategory.Label ?
			contact.bodyA.node :
			contact.bodyB.node
			
			if let message = labelNode as? MessageNode {
				message.didBounce()
			}
		}
		
		if !playable {
			return
		}
		
		if collision == PhysicsCategory.Cat | PhysicsCategory.Bed {
			print("SUCCESS")
			win()
		} else if collision == PhysicsCategory.Cat
			| PhysicsCategory.Edge {
			print("FAIL")
			lose()
		}
	}
	
	override func didSimulatePhysics() {
		if playable {
			if fabs(catNode.parent!.zRotation) >
				CGFloat(25).degreesToRadians() {
					lose()
			}
		}
	}
	
	func inGameMessage(text: String) {
		let message = MessageNode(message: text)
		message.position = CGPoint(x: frame.midX, y: frame.midY)
		addChild(message)
	}
	
	func newGame() {
		let scene = GameScene(fileNamed: "GameScene")
		scene!.scaleMode = scaleMode
		view!.presentScene(GameScene.level(levelNum: currentLevel))
	}
	
	func lose() {
		playable = false
		SKTAudio.sharedInstance().pauseBackgroundMusic()
		SKTAudio.sharedInstance().playSoundEffect("lose.mp3")
		
		inGameMessage(text: "Try again...")
		
		perform(#selector(newGame), with: nil, afterDelay: 5)
		catNode.wakeUp()
	}
	
	func win() {
		playable = false
		
		SKTAudio.sharedInstance().pauseBackgroundMusic()
		SKTAudio.sharedInstance().playSoundEffect("win.mp3")
		
		inGameMessage(text: "Nice job!")
		
		perform(#selector(GameScene.newGame), with: nil, afterDelay: 3)
		catNode.curlAt(scenePoint: bedNode.position)
	}
	
	
	
	
	
	
} // end of class
