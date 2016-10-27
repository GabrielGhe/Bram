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
            .setDateToShow(Date.s.addDays(daysToWait))
            .addProgress(answer.rank)
            .build()
    }
    
    init(deck: Deck) {
        self.queue = PriorityQueue<CardDue>(ascending: false)
        self.cardsPerDay = deck.cardsPerDay
        self.addCards(deck.cards)
    }
    
    func addCardDue(_ cardDue: CardDue) {
        addCardDues([cardDue])
    }
    
    func addCardDues(_ cardDues: [CardDue]) {
        for cardDue in cardDues {
            queue.push(cardDue)
        }
    }
    
    func deleteCardDue(_ cardDue: CardDue) {
        queue.remove(cardDue)
    }
    
    func updateCardDue(_ cardDue: CardDue) {
        deleteCardDue(cardDue)
        addCardDue(cardDue)
    }
    
    func addCard(_ card: Card) {
        addCards([card])
    }
    
    func addCards(_ cards: [Card]) {
        var cardDues: [CardDue] = []
        for card in cards {
            cardDues.append(CardDue(cardId: card.cardId, deckId: card.deckId, dateToShow: card.dateToShow))
        }
        addCardDues(cardDues)
    }
    
    func removeCardsDue(_ date: Date = Date.e) -> [CardDue] {
        var cardDues:[CardDue] = []
        var cardPeek = queue.peek()
        while !queue.isEmpty && cardPeek != nil && Date.isSmallerThan(cardPeek!.dateToShow, date) {
            assert(Date.isSmallerThan(cardPeek!.dateToShow, date))
            let cardDue = queue.pop()!
            cardDues.append(cardDue)
            cardPeek = queue.peek()
        }
        
        return cardDues
    }
    
    func getCardsDue(_ date: Date = Date.e) -> [CardDue] {
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
