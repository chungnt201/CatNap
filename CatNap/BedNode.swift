//
//  BedNode.swift
//  CatNap
//
//  Created by Patrick Bellot on 2/6/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import SpriteKit

class BedNode: SKSpriteNode, EventListnerNode {
	
	func didMoveToScene() {
		print("bed added to scene")
		
		let bedBodySize = CGSize(width: 40.0, height: 30.0)
		physicsBody = SKPhysicsBody(rectangleOf: bedBodySize)
		physicsBody!.isDynamic = false
	}
} // end of class
