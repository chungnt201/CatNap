//
//  HintNode.swift
//  CatNap
//
//  Created by Patrick Bellot on 2/16/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import SpriteKit

class HintNode: SKSpriteNode, EventListnerNode {
	
	var arrowPath: CGPath = {
		let bezierPath = UIBezierPath()
		bezierPath.move(to: CGPoint(x: 0.5, y: 65.69))
		bezierPath.addLine(to: CGPoint(x: 74.99, y: 1.5))
		bezierPath.addLine(to: CGPoint(x: 74.99, y: 38.66))
		bezierPath.addLine(to: CGPoint(x: 257.5, y: 38.66))
		bezierPath.addLine(to: CGPoint(x: 257.5, y: 92.72))
		bezierPath.addLine(to: CGPoint(x: 74.99, y: 92.72))
		bezierPath.addLine(to: CGPoint(x: 74.99, y: 126.5))
		bezierPath.addLine(to: CGPoint(x: 0.5, y: 65.69))
		bezierPath.close()
		return bezierPath.cgPath
	}()
	
	func didMoveToScene() {
		color = SKColor.clear
		
		let shape = SKShapeNode(path: arrowPath)
		shape.strokeColor = SKColor.gray
		shape.lineWidth = 4
		shape.fillColor = SKColor.white
		addChild(shape)
		
		shape.fillTexture = SKTexture(imageNamed: "wood_tinted")
		shape.alpha = 0.8
		shape.fillColor = SKColor.green
		
		
		let move = SKAction.moveBy(x: -40, y: 0, duration: 1.0)
		let bounce = SKAction.sequence([
			move, move.reversed()
			])
		let bounceAction = SKAction.repeat(bounce, count: 3)
		shape.run(bounceAction, completion: {
			self.removeFromParent()
		})
	}
}
