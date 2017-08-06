//
//  GameViewController.swift
//  iOSObjectiveCXXSwift
//
//  Created by Steph on 6/9/17.
//  Copyright © 2017 Steph Oro. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Configure the view.1920 × 1272
            
            let scene = GameScene(size: CGSize(width: 1920, height: 1272))
            scene.anchorPoint = CGPoint(x:0.5, y:0.5);

            view.showsFPS = true
            view.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            view.ignoresSiblingOrder = false
            
            scene.scaleMode = .aspectFill
            
            view.presentScene(scene)
        }
        ObjcShell.setView(self.view);
        ObjcShell.loadScene(withName: "spacecanyon");
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
