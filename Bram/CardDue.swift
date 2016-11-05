//
//  CardDue.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-10-22.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit

open class CardDue {
    private(set) var cardId: String
    private(set) var deckId: String
    private(set) var dateToShow: Date
    private(set) var priority: Int
    
    convenience init(card: Card) {
        self.init(cardId: card.cardId,
                  deckId: card.deckId,
                  dateToShow: card.dateToShow,
                  priority: card.associatedCardIds.count)
    }
    
    init(cardId: String, deckId: String, dateToShow: Date, priority: Int = 0) {
        self.cardId = cardId
        self.deckId = deckId
        self.dateToShow = dateToShow
        self.priority = priority
    }
}

extension CardDue : Equatable {}
extension CardDue : Comparable {}

public func ==(left: CardDue, right: CardDue) -> Bool {
    return (left.cardId == right.cardId)
}

public func <(left: CardDue, right: CardDue) -> Bool {
    return left.dateToShow.isGreaterThanDate(right.dateToShow) ||
        (Date.isSameDay(left.dateToShow, right.dateToShow) &&
        left.priority > right.priority)
}
