//
//  CardDue.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-10-22.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit
import RealmSwift

open class CardDue : Object {
    dynamic var cardId: String = UUID().uuidString
    dynamic var deckId: String = UUID().uuidString
    dynamic var dateToShow: Date = Date.s
    dynamic var isReminder: Bool = false
    
    convenience init(card: Card) {
        self.init(card: card, isReminder: false)
    }
    
    convenience init(card: Card, isReminder: Bool) {
        self.init(cardId: card.cardId,
                  deckId: card.deckId,
                  dateToShow: card.dateToShow,
                  isReminder: isReminder)
    }
    
    convenience init(cardId: String, deckId: String, dateToShow: Date, isReminder: Bool = false) {
        self.init()
        self.cardId = cardId
        self.deckId = deckId
        self.dateToShow = dateToShow
        self.isReminder = isReminder
    }
}

extension CardDue : Comparable {}

public func ==(left: CardDue, right: CardDue) -> Bool {
    return (left.cardId == right.cardId)
}

public func <(left: CardDue, right: CardDue) -> Bool {
    return left.dateToShow.isGreaterThanDate(right.dateToShow) ||
        Date.isSameDay(left.dateToShow, right.dateToShow)
}
