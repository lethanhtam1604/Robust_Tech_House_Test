//
//  BezierView.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/5/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit

protocol BezierViewDataSource: class {
    func bezierViewDataPoints(bezierView: BezierView) -> [CGPoint]
}

class BezierView: UIView {

    fileprivate let kStrokeAnimationKey = "StrokeAnimationKey"
    fileprivate let kFadeAnimationKey = "FadeAnimationKey"
    fileprivate let kColorAnimationKey = "fillColor"

    weak var dataSource: BezierViewDataSource?

    var lineColor = Global.colorMain
    var animates = true
    var pointLayers = [CAShapeLayer]()
    var lineLayer = CAShapeLayer()


    private var dataPoints: [CGPoint]? {
        return self.dataSource?.bezierViewDataPoints(bezierView: self)
    }

    private let cubicCurveAlgorithm = CubicCurveAlgorithm()

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.sublayers?.forEach({ (layer: CALayer) -> () in
            layer.removeFromSuperlayer()
        })

        pointLayers.removeAll()

        drawSmoothLines()
        drawPoints()

        animateLayers()
    }

    private func drawPoints(){

        guard let points = dataPoints else {
            return
        }

        for point in points {

            let circleLayer = CAShapeLayer()
            circleLayer.bounds = CGRect(x: 0, y: 0, width: 12, height: 12)
            circleLayer.path = UIBezierPath(ovalIn: circleLayer.bounds).cgPath
            circleLayer.fillColor = Global.colorMain.cgColor
            circleLayer.position = point

            circleLayer.shadowColor = UIColor.black.cgColor
            circleLayer.shadowOffset = CGSize(width: 0, height: 2)
            circleLayer.shadowOpacity = 0.7
            circleLayer.shadowRadius = 3.0

            self.layer.addSublayer(circleLayer)

            if animates {
                circleLayer.opacity = 0
                pointLayers.append(circleLayer)
            }
        }
    }

    func fadeColorAtPoint(_ index: Int) {

        animateColor(pointLayers[index])
    }

    private func drawSmoothLines() {

        guard let points = dataPoints else {
            return
        }

        let controlPoints = cubicCurveAlgorithm.controlPointsFromPoints(dataPoints: points)


        let linePath = UIBezierPath()

        for i in 0..<points.count {

            let point = points[i];

            if i==0 {
                linePath.move(to: point)
            } else {
                let segment = controlPoints[i-1]
                linePath.addCurve(to: point, controlPoint1: segment.controlPoint1, controlPoint2: segment.controlPoint2)
            }
        }

        lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = lineColor.cgColor
        lineLayer.lineWidth = 4.0

        lineLayer.shadowColor = UIColor.black.cgColor
        lineLayer.shadowOffset = CGSize(width: 0, height: 8)
        lineLayer.shadowOpacity = 0.5
        lineLayer.shadowRadius = 6.0

        self.layer.addSublayer(lineLayer)

        if animates {
            lineLayer.strokeEnd = 0
        }
    }
}

extension BezierView {

    func animateLayers() {
        animatePoints()
        animateLine()
    }

    private func animatePoints() {

        var delay = 0.2

        for point in pointLayers {

            let fadeAnimation = CABasicAnimation(keyPath: "opacity")
            fadeAnimation.toValue = 1
            fadeAnimation.beginTime = CACurrentMediaTime() + delay
            fadeAnimation.duration = 0.2
            fadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            fadeAnimation.fillMode = kCAFillModeForwards
            fadeAnimation.isRemovedOnCompletion = false

            point.add(fadeAnimation, forKey: kFadeAnimationKey)

            delay += 0.15
        }
    }

    private func animateLine() {

        let growAnimation = CABasicAnimation(keyPath: "strokeEnd")
        growAnimation.toValue = 1
        growAnimation.beginTime = CACurrentMediaTime() + 0.5
        growAnimation.duration = 1.5
        growAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        growAnimation.fillMode = kCAFillModeForwards
        growAnimation.isRemovedOnCompletion = false

        lineLayer.add(growAnimation, forKey: kStrokeAnimationKey)
    }

    func animateColor(_ shapeLayer: CAShapeLayer) {

        let colorAnimation = CABasicAnimation(keyPath: "fillColor")
        colorAnimation.fromValue = Global.colorMain.cgColor
        colorAnimation.toValue = UIColor.red.cgColor
        colorAnimation.duration = 0.5
        colorAnimation.repeatCount = 0
        colorAnimation.autoreverses = true

        shapeLayer.add(colorAnimation, forKey: kColorAnimationKey)
    }
}
