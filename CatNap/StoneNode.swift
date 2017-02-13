//
//  StoneNode.swift
//  CatNap
//
//  Created by Patrick Bellot on 2/13/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import SpriteKit

class StoneNode: SKSpriteNode, EventListnerNode, InteractiveNode {
	
	static func makeCompoundNode(in scene: SKScene) -> SKNode {
		let compound = StoneNode()
		
		for stone in scene.children.filter(
				{ node in node is StoneNode}) {
			stone.removeFromParent()
			compound.addChild(stone)
		}
		
		let bodies = compound.children.map({ node in
			SKPhysicsBody(rectangleOf: node.frame.size, center: node.position)
		})
		
		
		
		
		
		
		return compound
	}
	
	func didMoveToScene() {
		
		
	}
	
	func interact() {
		
		
	}

} // end of class
