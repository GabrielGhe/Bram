//
//  DeckTableViewCell.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-12-10.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit
import SnapKit

class DeckTableViewCell: UITableViewCell {
    @IBOutlet weak var myView: UIView!
    
    func createView(withTitle title: String) {
        let iconLabel = createIconLabel()
        let titleLabel = createLabel(withTitle: title)
        
        self.myView.addSubview(iconLabel)
        self.myView.addSubview(titleLabel)
        
        arrangeViews(iconLabel: iconLabel, titleLabel: titleLabel)
    }
    
    func arrangeViews(iconLabel: UILabel, titleLabel: UILabel) {
        iconLabel.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(myView).inset(UIEdgeInsetsMake(5, 10, 5, 10))
        }
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(myView).inset(UIEdgeInsetsMake(5, 35, 5, 10))
        }
    }
    
    func createLabel(withTitle title:String) -> UILabel{
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 18)
        label.text = title
        return label
    }
    
    func createIconLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 15)
        label.text = String.fontAwesomeIcon(code: "fa-list")
        //label.textColor = UIColor.blue
        return label
    }
}
