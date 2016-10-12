//
//  Scheduler.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-10-12.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit

class Scheduler {
    static func scheduleShowTime(card: Card, answer: TimeAdded) -> Card {
        let temp = Double(card.getDaysToWait()) * answer.rawValue
        let daysToWait = Int(temp + 0.5) + 1
        
        return Card.Builder()
            .setCard(card)
            .setDaysToWait(daysToWait)
            .setDateToShow(Date().addDays(daysToWait))
            .build()
    }
}
