//
//  StringExtension.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-12-04.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit

extension String {
    public func getMatches(text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: self)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    public func matches(text: String) -> Bool {
        let matches = getMatches(text: text)
        return matches.count > 0
    }
}
