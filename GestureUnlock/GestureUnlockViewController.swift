//
//  GestureUnlockViewController.swift
//  GestureUnlock
//
//  Created by LiuJinjun on 16/7/28.
//  Copyright © 2016年 NetEase Youdao. All rights reserved.
//

import UIKit

class GestureUnlockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let unlockView = GestureUnlockView(frame: view.frame)
        view.addSubview(unlockView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
