//
//  Storage.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-12-29.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

protocol Storage {
    func getDecks(forUserId: String) -> [Deck]
    func getDecks() -> [Deck]
    func getCards(forDeck: String) -> [Card]
    func getCards(forUserId: String) -> [Card]
    func save(deck: Deck)
    func save(card: Card)
    func deleteDecks(forUserId: String)
    func deleteCards(forUserId: String)
}
