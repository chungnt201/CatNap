//
//  CatNode.swift
//  CatNap
//
//  Created by Patrick Bellot on 2/6/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import SpriteKit

class CatNode: SKSpriteNode, EventListnerNode, InteractiveNode {
	
	static let kCatTappedNotification = "kCatTappedNotification"
	
	func interact() {
		NotificationCenter.default.post(Notification(name: Notification.Name(CatNode.kCatTappedNotification),
		                                             object: nil))
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		interact()
	}
	
	func didMoveToScene() {
		print("cat added to scene")
		
		let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
		
		parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture,
		                                    size: catBodyTexture.size())
		parent!.physicsBody!.categoryBitMask = PhysicsCategory.Cat
		parent!.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Edge | PhysicsCategory.Spring
		parent!.physicsBody!.contactTestBitMask = PhysicsCategory.Bed | PhysicsCategory.Edge
		
		isUserInteractionEnabled = true
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
	
	func curlAt(scenePoint: CGPoint) {
		parent!.physicsBody = nil
		
		for child in children {
			child.removeFromParent()
		}
		texture = nil
		color = SKColor.clear
		
		let catCurl = SKSpriteNode(fileNamed: "CatCurl")!.childNode(withName: "cat_curl")!
		catCurl.move(toParent: self)
		catCurl.position = CGPoint(x: -30, y: 100)
		
		var localPoint = parent!.convert(scenePoint, to: scene!)
		localPoint.y += frame.size.height/3
		
		run(SKAction.group([
			SKAction.move(to: localPoint, duration: 0.66),
			SKAction.rotate(byAngle: -parent!.zRotation, duration: 0.5)
			]))
	}
}
