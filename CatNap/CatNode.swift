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
	}
}
