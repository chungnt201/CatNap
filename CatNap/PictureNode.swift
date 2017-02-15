//
//  PictureNode.swift
//  CatNap
//
//  Created by Patrick Bellot on 2/15/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import SpriteKit

class PictureNode: SKSpriteNode, EventListnerNode, InteractiveNode {
	
	func didMoveToScene() {
		isUserInteractionEnabled = true
		
		let pictureNode = SKSpriteNode(imageNamed: "picture")
		let maskNode = SKSpriteNode(imageNamed: "picture-frame-mask")
		let cropNode = SKCropNode()
		cropNode.addChild(pictureNode)
		cropNode.maskNode = maskNode
		addChild(cropNode)
	}
	
	func interact() {
		isUserInteractionEnabled = false
		physicsBody!.isDynamic = true
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		interact()
	}
} // end of class
