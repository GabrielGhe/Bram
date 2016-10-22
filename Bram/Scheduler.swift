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
    fileprivate var queue: PriorityQueue<CardDue>
    fileprivate var cardsPerDay: Int
    
    static func scheduleShowTime(card: Card, answer: TimeAdded) -> Card {
        let temp = Double(card.daysToWait) * answer.rawValue
        let daysToWait = Int(temp + 0.5) + 1
        
        return Card.Builder()
            .setCard(card)
            .setDaysToWait(daysToWait)
            .setDateToShow(Date().addDays(daysToWait))
            .build()
    }
    
    init(deck: Deck) {
        self.queue = PriorityQueue<CardDue>(ascending: false)
        self.cardsPerDay = deck.cardsPerDay
        self.addCardDues(deck.cards)
    }
    
    func addCardDue(_ cardDue: CardDue) {
        addCardDues([cardDue])
    }
    
    func deleteCardDue(_ cardDue: CardDue) {
        
    }
    
    func updateCardDue(_ cardDue: CardDue) {
        
    }
    
    func addCardDues(_ cardDues: [CardDue]) {g
        
    }
    
    func addCardDue(_ card: Card) {
        
    }
    
    func addCardDues(_ cards: [Card]) {
        
    }

    func getCardsDue(_ date: Date = Date()) -> [CardDue] {
        var cardDues:[CardDue] = []
        var ctr = 0
        var gen = queue.makeIterator()
        var current = gen.next()
        
        while current != nil && ctr < self.cardsPerDay {
            if let current = current {
                if Date.isSmallerThan(current.dateToShow, date) {
                    cardDues.append(current)
                } else {
                    break
                }
            }
            ctr += 1
            current = gen.next()
        }
        
        return cardDues
    }
}
