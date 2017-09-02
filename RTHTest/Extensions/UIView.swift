//
//  UIView.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/1/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit

extension UIView {

    func increaseSize() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1
        animation.fromValue = 0
        animation.duration = 0.3
        animation.autoreverses = false
        self.layer.add(animation, forKey: nil)
    }

    func shawdow(_ color: UIColor) {
        layer.cornerRadius = 5
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}
