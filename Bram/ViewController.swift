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
    
    fileprivate func createView() {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 100)
        label.text = String.fontAwesomeIcon(code: "fa-github")
        label.textColor = UIColor.blue
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view)
        }
    }
}

