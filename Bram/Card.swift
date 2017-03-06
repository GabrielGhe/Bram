//
//  Card.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-09-22.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit
import RealmSwift

open class Card : Object {
    dynamic var userId: String = UIDevice.current.identifierForVendor!.uuidString
    dynamic var cardId: String = UUID().uuidString
    dynamic var deckId: String = UUID().uuidString
    dynamic var question: String = ""
    dynamic var answer: String = ""
    dynamic var creationDate: Date = Date.s
    var associatedCardIds: List<CardDue> = List<CardDue>()
    dynamic var dateToShow: Date = Date.s
    dynamic var daysToWait: Int = 1
    
    convenience init(userId: String, cardId:String, deckId:String, question:String, answer:String,
                     creationDate: Date, associatedCards: List<CardDue>, dateToShow: Date, daysToWait: Int) {
        self.init()
        self.cardId = cardId
        self.deckId = deckId
        self.question = question
        self.answer = answer
        self.creationDate = creationDate
        self.dateToShow = dateToShow
        self.associatedCardIds = associatedCards
        self.daysToWait = daysToWait
        self.userId = userId
    }
}
extension Card : Comparable {}

public func ==(left: Card, right: Card) -> Bool {
    return (left.cardId == right.cardId)
}

public func <(left: Card, right: Card) -> Bool {
    return left.dateToShow.isGreaterThanDate(right.dateToShow)
}
