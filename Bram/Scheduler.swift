//
//  Scheduler.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-10-12.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit
import SwiftPriorityQueue

class Scheduler {
    static func scheduleShowTime(card: Card, answer: TimeAdded) -> Card {
        return scheduleShowTime(card: card, answer: answer, fromDate: Date.s)
    }
    
    static func scheduleShowTime(card: Card, answer: TimeAdded, fromDate date: Date) -> Card {
        let temp = Double(card.daysToWait) * answer.rawValue
        let daysToWait = Int(temp + 0.5) + 1
        
        return CardBuilder()
            .setCard(card)
            .setDaysToWait(daysToWait)
            .setDateToShow(date.addDays(daysToWait))
            .build()
    }
}
