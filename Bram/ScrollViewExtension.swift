//
//  ScrollViewExtension.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-03-07.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}
