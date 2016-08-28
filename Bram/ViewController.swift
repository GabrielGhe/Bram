//
//  ViewController.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-08-28.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit
import FontAwesome_swift
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
    
    private func createView() {
        let label = UILabel()
        label.font = UIFont.fontAwesomeOfSize(20)
        label.text = String.fontAwesomeIconWithCode("fa-github")
        label.textColor = UIColor.blueColor()
        self.view.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view)
        }
    }
}

