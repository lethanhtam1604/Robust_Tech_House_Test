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
}
