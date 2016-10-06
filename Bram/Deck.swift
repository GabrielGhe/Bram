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
    
    convenience init(name: String) {
        self.init(name, [], uuid: UUID().uuidString)
    }
    
    init(_ name: String, _ cards: [Card], uuid: String) {
        self.mName = name
        self.mQueue = PriorityQueue<Card>(ascending: false)
        self.mId = uuid
        addCards(cards)
    }
    
    func addCard(_ card: Card) {
        addCards([card])
    }
    
    func deleteCard(_ card: Card) {
        mQueue.remove(card)
    }
    
    fileprivate func addCards(_ cards: [Card]) {
        for card in cards {
            mQueue.push(card)
        }
    }
}
