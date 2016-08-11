//
//  InkPresenterView.swift
//  GestureUnlock
//
//  Created by LiuJinjun on 16/7/27.
//  Copyright © 2016年 NetEase Youdao. All rights reserved.
//

import UIKit

class InkPresenterView: UIView {
    var lastPoint: CGPoint!
    var lineColor: UIColor = UIColor.blackColor()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = UIColor.whiteColor()
    }
    
//    override func drawRect(rect: CGRect) {
//        let context = UIGraphicsGetCurrentContext()
//        CGContextMoveToPoint(context, startPoint.x, startPoint.y)
//        CGContextAddLineToPoint(context, endPoint.x, endPoint.y)
//        CGContextSetLineWidth(context, 5)
//        CGContextSetLineCap(context, .Round)
//        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1)
//        CGContextStrokePath(context)
//    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch?.locationInView(touch?.view)
        lastPoint = point!
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch?.locationInView(touch?.view)
        print(point)
        addLine(lastPoint, endPoint: point!)
        lastPoint = point
    }
    
    func addLine(startPoint: CGPoint, endPoint: CGPoint) {
        let lineLayer = CAShapeLayer()
        let bezier = UIBezierPath()
        bezier.moveToPoint(startPoint)
        bezier.addLineToPoint(endPoint)
        bezier.lineCapStyle = .Round
        lineLayer.path = bezier.CGPath
        lineLayer.strokeColor = lineColor.CGColor
        lineLayer.lineCap = kCALineCapRound
        lineLayer.lineWidth = 5
        layer.addSublayer(lineLayer)
    }

}
