//
//  ViewController.swift
//  canvas-lab
//
//  Created by Rodrigo Bell on 3/15/17.
//  Copyright © 2017 Rodrigo Bell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var travView: UIView!
    var originalTrayCenter: CGPoint?
    var trayCenterWhenOpen: CGPoint?
    var trayCenterWhenClosed: CGPoint?
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceInitialCenter: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.trayCenterWhenOpen = travView.center
        self.trayCenterWhenClosed = CGPoint(x: travView.center.x, y: travView.center.y + 220)
    }

    @IBAction func onFacePanGesture(_ sender: AnyObject) {
        
        let translation = sender.translation(in: view)
        let imageView = sender.value(forKey: "view") as! UIImageView
        
        if sender.state == UIGestureRecognizerState.began {
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += travView.frame.origin.y
            newlyCreatedFaceInitialCenter = newlyCreatedFace.center
        } else if sender.state == UIGestureRecognizerState.changed {
            newlyCreatedFace.center = CGPoint(x: (newlyCreatedFaceInitialCenter?.x)! + translation.x, y: newlyCreatedFace.center.y + translation.y)
        }
    }
    
    @IBAction func onTrayPanGestures(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.travView)
        
        if (sender.state == UIGestureRecognizerState.began) {
            originalTrayCenter = travView.center
            NSLog("Gesture began at: %@", NSStringFromCGPoint(translation))
            
        } else if (sender.state == UIGestureRecognizerState.changed) {
            travView.center = CGPoint(x: (originalTrayCenter?.x)!, y: (originalTrayCenter?.y)! + translation.y)
            NSLog("Gesture changed at: %@", NSStringFromCGPoint(translation))
            
        } else if (sender.state == UIGestureRecognizerState.ended) {
            let velocity = sender.velocity(in: self.travView)
            if velocity.y >= 0 {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.travView.center = self.trayCenterWhenClosed!
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.travView.center = self.trayCenterWhenOpen!
                })
            }
            NSLog("Gesture ended at: %@", NSStringFromCGPoint(translation))
            
        }
    }


}

