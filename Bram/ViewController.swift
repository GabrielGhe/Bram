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
import SwiftPriorityQueue

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
        
        let card1 = Card.Builder()
            .setId("1234")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        let card2 = Card.Builder()
            .setId("2345")
            .setQuestion("question 2")
            .setAnswer("answer 2")
            .setDateToShow(NSDate().addDays(1))
            .build()
        
        var queue = PriorityQueue<Card>(ascending: false)
        
        queue.push(card1)
        queue.push(card2)
        
        print(queue.peek() == card1)
        
        print(card1 > card2)
    }
}

