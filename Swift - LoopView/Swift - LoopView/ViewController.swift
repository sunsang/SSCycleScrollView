//
//  ViewController.swift
//  Swift - LoopView
//
//  Created by nice on 2018/10/15.
//  Copyright © 2018 NICE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cycleView: SSCycleScrollView = SSCycleScrollView.init(frame: CGRect(origin: .zero, size: CGSize.init(width: self.view.frame.size.width, height: 200)))
        self.view.addSubview(cycleView)
//        cycleView.snp.makeConstraints { (make) in
//            make.left.right.top.equalToSuperview()
//            make.height.equalTo(200)
//        }
        
    }


}

