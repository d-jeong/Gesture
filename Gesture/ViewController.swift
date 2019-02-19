//
//  ViewController.swift
//  Gesture
//
//  Created by Jeong, David Y. on 2/18/19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var androidImageView: UIImageView!
    @IBOutlet weak var trashImageView: UIImageView!
    
    private var androidOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addPanGesture(view: androidImageView)
        view.bringSubviewToFront(androidImageView)
        androidOrigin = androidImageView.center
    }

    private func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handelPan(sender:)))
        view.addGestureRecognizer(pan)
    }

    @objc
    private func handelPan(sender: UIPanGestureRecognizer) {
        guard let senderView = sender.view else { return }

        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: senderView, sender: sender)
        case .ended:
            endMoveWithPan(view: senderView)
        default:
            break
        }
    }
    
    private func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(.zero, in: self.view)
    }
    
    private func endMoveWithPan(view: UIView) {
        if view.frame.intersects(trashImageView.frame) {
            UIView.animate(withDuration: 0.5) {
                view.alpha = 0
            }
        }
        else {
            UIView.animate(withDuration: 0.5) {
                view.center = self.androidOrigin
            }
        }
    }
}

