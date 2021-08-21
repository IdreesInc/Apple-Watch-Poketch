//
//  GameView.swift
//  Etch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene {
    override func sceneDidLoad() {
        print("scene loaded")
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        let shape = SKShapeNode()
        shape.path = UIBezierPath(roundedRect: CGRect(x: -128, y: -128, width: 256, height: 256), cornerRadius: 64).cgPath
        shape.position = CGPoint(x: frame.midX, y: frame.midY)
        shape.fillColor = UIColor.red
        shape.strokeColor = UIColor.blue
        shape.lineWidth = 10
        addChild(shape)
    }
    
}

struct GameView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 300, height: 400)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 300, height: 400)
            .ignoresSafeArea()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
