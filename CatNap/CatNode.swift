//
//  CatNode.swift
//  CatNap
//
//  Created by Patrick Bellot on 2/6/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import SpriteKit

class CatNode: SKSpriteNode, EventListnerNode {
	
	func didMoveToScene() {
		print("cat added to scene")
		
		let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
		
		parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture,
		                                    size: catBodyTexture.size())
		parent!.physicsBody!.categoryBitMask = PhysicsCategory.Cat
		parent!.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Edge
		parent!.physicsBody!.contactTestBitMask = PhysicsCategory.Bed | PhysicsCategory.Edge
	}
	
	func wakeUp() {
		
		for child in children {
			child.removeFromParent()
		}
		texture = nil
		color = SKColor.clear
		
		let catAwake = SKSpriteNode(fileNamed: "CatWakeUp")!.childNode(withName: "cat_awake")!
		catAwake.move(toParent: self)
		catAwake.position = CGPoint(x: -30, y: 100)
	}
}
