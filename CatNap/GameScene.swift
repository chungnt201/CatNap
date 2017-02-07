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
}

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var bedNode: BedNode!
	var catNode: CatNode!
    
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
		
//		bedNode.setScale(1.5)
//		catNode.setScale(1.5)
	}
}
