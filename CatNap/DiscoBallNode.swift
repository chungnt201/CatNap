//
//  DiscoBallNode.swift
//  CatNap
//
//  Created by Patrick Bellot on 2/15/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import SpriteKit
import AVFoundation

class DiscoBallNode: SKSpriteNode, EventListnerNode, InteractiveNode{
	
	private var player: AVPlayer!
	private var video: SKVideoNode!
	private var isDiscoTime: Bool = false {
		didSet {
			video.isHidden = !isDiscoTime
		
			if isDiscoTime {
				video.play()
				run(spinAction)
			} else {
				video.pause()
				removeAllActions()
			}
			
			SKTAudio.sharedInstance().playBackgroundMusic(
				isDiscoTime ? "disco-sound.m4a" : "backgroundMusic.mp3")
			
			if isDiscoTime {
				video.run(SKAction.wait(forDuration: 5.0), completion: {
					self.isDiscoTime = false
				})
			}
		}
	}
	
	private let spinAction = SKAction.repeatForever(
		SKAction.animate(with: [
			SKTexture(imageNamed: "discoball1"),
			SKTexture(imageNamed: "discoball2"),
			SKTexture(imageNamed: "discoball3")
			], timePerFrame: 0.2))
	
	func didMoveToScene() {
		isUserInteractionEnabled = true
		
		let fileUrl = Bundle.main.url(forResource: "discolights-loop", withExtension: "mov")!
		player = AVPlayer(url: fileUrl)
		video = SKVideoNode(avPlayer: player)
		
		video.size = scene!.size
		video.position = CGPoint(x: scene!.frame.midX,
		                         y: scene!.frame.midY)
		video.zPosition = -1
		scene!.addChild(video)
		
		video.isHidden = true
		video.pause()
		video.alpha = 0.75
		
		NotificationCenter.default.addObserver(self, selector: #selector(didReachEndOfVideo),
		                                       name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
		                                       object: nil)
	}
	
	func didReachEndOfVideo() {
		print("rewind")
		player.currentItem!.seek(to: kCMTimeZero)
		player.play()
	}
	
	func interact() {
		if !isDiscoTime {
			isDiscoTime = true
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		interact()
	}
}
