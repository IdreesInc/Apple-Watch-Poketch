//
//  GameView.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene {
    override func sceneDidLoad() {
        print("scene loaded")
        self.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1.0);
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
        scene.size = CGSize(width: 300, height: 500)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 300, height: 500)
            .edgesIgnoringSafeArea(.all)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .padding(.top, -10.0).navigationBarHidden(true)
    }
}
