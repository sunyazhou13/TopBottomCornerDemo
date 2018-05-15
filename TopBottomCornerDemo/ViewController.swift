//
//  ViewController.swift
//  TopBottomCornerDemo
//
//  Created by sunyazhou on 2018/5/15.
//  Copyright © 2018年 Kwai Co., Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView = UIView()
        view.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cardView.backgroundColor = UIColor(red: 1.0, green: 0.784, blue: 0.2, alpha: 1)
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateCornerChange(recognizer:)))
        cardView.addGestureRecognizer(tapRecognizer)
        
    }

    
    
    @objc func animateCornerChange(recognizer: UITapGestureRecognizer) {
        let targetRadius: Double = (cardView.layer.cornerRadius == 0.0) ? 100.0:0.0
        
        if #available(iOS 10.0, *) {
            UIViewPropertyAnimator(duration: 0.4, curve: .easeInOut) {
                self.cardView.roundCorners(cornerRadius: targetRadius)
                }.startAnimation()
        } else {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                self.cardView.roundCorners(cornerRadius: targetRadius)
            }, completion: nil)
        }
    }
}

extension UIView {
    func roundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
        
    }
}
