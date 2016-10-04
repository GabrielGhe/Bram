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
    private var mQueue: PriorityQueue<Card>
    private let mName: String
    private let mId: String
    
    convenience init(name: String) {
        self.init(name, [], UUID().uuidString)
    }
    
    init(_ name: String, _ cards: [Card], uuid: String) {
        self.mName = name
        self.mQueue = PriorityQueue<Card>(ascending: false)
        self.mId = uuid
        addCards(cards)
    }
    
    func addCard(card: Card) {
        addCards([card])
    }
    
    func deleteCard(card: Card) {
        mQueue.remove(card)
    }
    
    private func addCards(cards: [Card]) {
        for card in cards {
            mQueue.push(card)
        }
    }
}
