//
//  ViewController.swift
//  SpaceFighter
//
//  Created by Jon Alaniz on 11/10/20.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewWillAppear() {
        self.view.window?.aspectRatio = NSSize(width: 800, height: 600)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameScene()
    }
    
    func setupGameScene() {
        let scene = GameScene(size: CGSize(width: 800, height: 600))
        scene.scaleMode = .aspectFit
        scene.anchorPoint = CGPoint(x: 0, y: 0)
        
        skView = self.view as? SKView
        skView.presentScene(scene)
    }
}

