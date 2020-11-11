//
//  GameScene.swift
//  SpaceFighter
//
//  Created by Jon Alaniz on 11/10/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let player1 = SKSpriteNode(imageNamed: "shipBlack")
    let player2 = SKSpriteNode(imageNamed: "shipBlue")
    
    var keysPressed: Set<Int> = []
    
    override func didMove(to view: SKView) {
        setupGame()
        startGame()
    }
    
    override func keyDown(with event: NSEvent) {
        keysPressed.insert(Int(event.keyCode))
    }
    
    override func keyUp(with event: NSEvent) {
        keysPressed.remove(Int(event.keyCode))
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        pollKeyboard()
        
        for node in children {
            // Loop over all nodes and make sure they are not off screen
            if node.position.y > frame.maxY {
                // This node has gone off the top, move it to the bottom
                // Make sure to stop movement or there will be a delay
                node.removeAllActions()
                node.position.y = frame.minY
            } else if node.position.y < frame.minY {
                // This node has gone off the bottom, move it to the top
                node.removeAllActions()
                node.position.y = frame.maxY
            }
            
            if node.position.x > frame.maxX {
                // This node has gone off the right, move it to the left
                node.removeAllActions()
                node.position.x = frame.minX
            } else if node.position.x < frame.minX {
                // This node has gone off the left, move it to the right
                node.removeAllActions()
                node.position.x = frame.maxX
            }
            
        }
    }
    
    func setupGame() {
        backgroundColor = .black
        physicsWorld.gravity = .zero
        
        let size = CGSize(width: player1.size.width / 2, height: player1.size.height / 2)
        
        player1.zPosition = 1
        player1.name = "player1"
        player1.setScale(0.5)
        player1.physicsBody = SKPhysicsBody(texture: player1.texture!, size: size)
        
        player2.zPosition = 1
        player2.name = "player2"
        player2.setScale(0.5)
        player2.physicsBody = SKPhysicsBody(texture: player2.texture!, size: size)
    }
    
    func startGame() {
        player1.position = CGPoint(x: frame.midX - 150, y: frame.midY)
        player2.position = CGPoint(x: frame.midX + 150, y: frame.midY)
        
        addChild(player1)
        addChild(player2)
    }
    
    func pollKeyboard() {
        for key in keysPressed {
            switch key {
            // These keys move Player 1
            case Key.A.rawValue:
                movePlayer(ship: player1, direction: .left)
            case Key.D.rawValue:
                movePlayer(ship: player1, direction: .right)
            case Key.W.rawValue:
                movePlayer(ship: player1, direction: .up)
                
            // These keys move Player 2
            case Key.Left.rawValue:
                movePlayer(ship: player2, direction: .left)
            case Key.Right.rawValue:
                movePlayer(ship: player2, direction: .right)
            case Key.Up.rawValue:
                movePlayer(ship: player2, direction: .up)
            default:
                print("default")
            }
        }
    }
    
    func movePlayer(ship player: SKSpriteNode, direction: Direction) {
        var movement = SKAction()
        
        switch direction {
        case .left:
            movement = SKAction.rotate(byAngle: .pi / 20, duration: 0)
        case .right:
            movement = SKAction.rotate(byAngle: -(.pi / 20), duration: 0)
        case .up:
            let distance: CGFloat = 150
            let rotation = player.zRotation - 1.57
            let xPosition = distance * -cos(rotation) + player.position.x
            let yPosition = distance * -sin(rotation) + player.position.y
            
            movement = SKAction.move(to: CGPoint(x: xPosition, y: yPosition), duration: 0.8)
        }
        
        player.run(movement)
    }
}
