//
//  SwipeableViewController.swift
//  iOS-assignment
//
//  Created by Pavle Mijatovic on 27.4.21..
//

import UIKit

class SwipeableViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSwipeDownGesture()
    }
    
    // MARK: - Helper
    private func addSwipeDownGesture() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    // MARK: - Actions
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.down:
            swipeDown()
        default:
            break
        }
    }
    
    func swipeDown() {}
}
