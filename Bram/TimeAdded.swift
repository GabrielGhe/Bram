//
//  TimeAdded.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-10-12.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

enum TimeAdded: Double {
    case BAD = 0
    case OK = 1
    case GOOD = 1.4
    case GREAT = 1.8
    
    var rank: UInt8 {
        switch (self) {
        case .BAD:
            return 0
        case .OK:
            return 1
        case .GOOD:
            return 2
        case .GREAT:
            return 3
        }
    }
}
