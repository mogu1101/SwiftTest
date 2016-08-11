//
//  RootViewController.swift
//  GestureUnlock
//
//  Created by LiuJinjun on 16/7/27.
//  Copyright © 2016年 NetEase Youdao. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    let cellId = "cell"
    let titles = ["手势解锁", "涂鸦板"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        let tableView = UITableView(frame: view.frame, style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(tableView)
    }

}

extension RootViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        cell.selectionStyle = .None
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
}

extension RootViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let unlock = GestureUnlockViewController()
            self.showViewController(unlock, sender: self)
        case 1:
            let ink = InkPresenterViewController()
            self.showViewController(ink, sender: self)
        default:
            break
        }
    }
}
