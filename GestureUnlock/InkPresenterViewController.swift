//
//  InkPresenterViewController.swift
//  GestureUnlock
//
//  Created by LiuJinjun on 16/7/27.
//  Copyright © 2016年 NetEase Youdao. All rights reserved.
//

import UIKit

class InkPresenterViewController: UIViewController {
    private var lastColorButton: UIButton? = nil
    private lazy var colorBoardView: UIView = {
        let width = UIScreen.mainScreen().bounds.width / 8
        let boardView = UIView(frame: CGRect(x: 0, y: UIScreen.mainScreen().bounds.height-50, width: UIScreen.mainScreen().bounds.width, height: 50))
        boardView.backgroundColor = UIColor.grayColor()
        for i in 0..<8 {
            let colorView = UIButton(frame: CGRect(x: CGFloat(i)*width, y: 0, width: width, height: width))
            colorView.backgroundColor = UIColor.randomColor()
            colorView.layer.borderWidth = 2
            colorView.layer.borderColor = UIColor.lightGrayColor().CGColor
            colorView.addTarget(self, action: #selector(self.chooseColor(_:)), forControlEvents: .TouchUpInside)
            boardView.addSubview(colorView)
        }
        return boardView
    }()
    
    private lazy var inkView: InkPresenterView = {
        let ink = InkPresenterView()
        return ink
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        view.backgroundColor = UIColor.whiteColor()
        inkView.frame = view.frame
        view.addSubview(inkView)
        view.addSubview(colorBoardView)
    }
    
    func chooseColor(button: UIButton) {
        print(button.backgroundColor)
        inkView.lineColor = button.backgroundColor!
        if lastColorButton != nil {
            lastColorButton!.layer.borderColor = UIColor.lightGrayColor().CGColor
        }
        button.layer.borderColor = UIColor.blackColor().CGColor
        lastColorButton = button
    }
}
