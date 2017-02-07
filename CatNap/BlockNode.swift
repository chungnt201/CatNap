//
//  BlockNode.swift
//  CatNap
//
//  Created by Patrick Bellot on 2/7/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import SpriteKit

class BlockNode: SKSpriteNode, EventListnerNode, InteractiveNode {
	
	func didMoveToScene() {
		isUserInteractionEnabled = true
	}
	
	func interact() {
		isUserInteractionEnabled = true
		
		run(SKAction.sequence([
			SKAction.playSoundFileNamed("pop.mp3",
			                            waitForCompletion: false),
			SKAction.scale(to: 0.8, duration: 0.1),
			SKAction.removeFromParent()
			]))
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		print("destroy block")
		interact()
	}
}
