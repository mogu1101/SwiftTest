//
//  GestureUnlockView.swift
//  GestureUnlock
//
//  Created by LiuJinjun on 16/7/25.
//  Copyright © 2016年 NetEase Youdao. All rights reserved.
//

import UIKit

enum TouchState {
    case NotStart
    case Moving
    case LockSetted
    case UnlockSucceed
    case UnlockFailed
}

class GestureUnlockView: UIView {
    var buttons: [UIButton]? = []
    var currentPoint: CGPoint?
    var lock: [UIButton]? = []
    var touchState: TouchState = .NotStart
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        backgroundColor = UIColor.whiteColor()
        for i in 0..<9 {
            let button = UIButton(type: .Custom)
            let row = CGFloat(i/3)
            let col = CGFloat(i%3)
            let buttonWidth = CGFloat(60)
            let margin = CGFloat(20)
            let startX = center.x - 1.5*buttonWidth - margin
            let startY = center.y - 1.5*buttonWidth - margin
            button.frame = CGRect(x: startX+row*(buttonWidth+margin), y: startY+col*(buttonWidth+margin), width: buttonWidth, height: buttonWidth)
            button.setBackgroundImage(UIImage.imageWithColor(UIColor.brownColor()), forState: .Normal)
            button.setBackgroundImage(UIImage.imageWithColor(UIColor.yellowColor()), forState: .Selected)
            button.layer.cornerRadius = buttonWidth/2
            button.layer.masksToBounds = true
            button.userInteractionEnabled = false
            button.tag = i
            addSubview(button)
        }
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        for i in 0..<buttons!.count {
            let button = buttons![i]
            if i == 0 {
                CGContextMoveToPoint(context, button.center.x, button.center.y)
            } else {
                CGContextAddLineToPoint(context, button.center.x, button.center.y)
            }
        }
        if buttons!.count != 0 && touchState == .Moving {
            CGContextAddLineToPoint(context, currentPoint!.x, currentPoint!.y)
        }
        CGContextSetLineWidth(context, 10)
        CGContextSetLineCap(context, .Round)
        CGContextSetLineJoin(context, .Round)
        switch touchState {
        case .Moving:
            CGContextSetRGBStrokeColor(context, 0, 0, 0, 1)
        case .LockSetted:
            CGContextSetRGBStrokeColor(context, 0, 0, 1, 1)
        case .UnlockSucceed:
            CGContextSetRGBStrokeColor(context, 0, 1, 0, 1)
        case .UnlockFailed:
            CGContextSetRGBStrokeColor(context, 1, 0, 0, 1)
        default:
            break
        }
        CGContextStrokePath(context)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchState = .Moving
        let startPoint = getCurrentPoint(touches)
        let button = getCurrentButton(startPoint)
        if button != nil && button?.selected == false {
            button?.selected = true
            buttons?.append(button!)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let movePoint = getCurrentPoint(touches)
        let button = getCurrentButton(movePoint)
        currentPoint = movePoint
        if button != nil && button?.selected == false {
            button?.selected = true
            buttons?.append(button!)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if lock == nil || lock?.count == 0 {
            lock = buttons
            print("设置手势成功")
            touchState = .LockSetted
        } else if (lock! == buttons!) {
            print("解锁成功")
            touchState = .UnlockSucceed
        } else {
            print("手势错误")
            touchState = .UnlockFailed
        }
        self.setNeedsDisplay()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            for button in self.buttons! {
                button.selected = false
            }
            self.buttons?.removeAll()
            self.setNeedsDisplay()
        }
    }
    
    func getCurrentPoint(touches: Set<UITouch>) -> CGPoint {
        let touch = touches.first
        let point = touch?.locationInView(touch?.view)
        return point!
    }
    
    func getCurrentButton(point: CGPoint) -> UIButton? {
        for button in subviews as! [UIButton] {
            if CGRectContainsPoint(button.frame, point) {
                return button
            }
        }
        return nil
    }
}
