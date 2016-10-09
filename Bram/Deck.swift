//
//  Deck.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-09-26.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit
import SwiftPriorityQueue

class Deck {
    fileprivate var mQueue: PriorityQueue<Card>
    fileprivate let mName: String
    fileprivate let mId: String
    fileprivate let mCardsPerDay: Int
    
    convenience init(name: String) {
        self.init(name, [], uuid: UUID().uuidString, cardsPerDay: 10)
    }
    
    init(_ name: String, _ cards: [Card], uuid: String, cardsPerDay: Int) {
        self.mId = uuid
        self.mName = name
        self.mQueue = PriorityQueue<Card>(ascending: false)
        self.mCardsPerDay = cardsPerDay
        addCards(cards)
    }
    
    func addCard(_ card: Card) {
        addCards([card])
    }
    
    func deleteCard(_ card: Card) {
        mQueue.remove(card)
    }
    
    func addCards(_ cards: [Card]) {
        for card in cards {
            mQueue.push(card)
        }
    }
    
    func getCardsDue() -> [Card] {
        var cardsDue:[Card] = []
        var ctr = 0
        var gen = mQueue.makeIterator()
        var current = gen.next()
        
        while current != nil && ctr < mCardsPerDay {
            if let current = current {
                if Date.isSmallerThan(current.getDateToShow(), Date()) {
                    cardsDue.append(current)
                } else {
                    break
                }
            }
            ctr += 1
            current = gen.next()
        }
        
        return cardsDue
    }
}
