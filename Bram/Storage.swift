//
//  Storage.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-12-29.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

protocol Storage {
    func getDecks() -> [Deck]
    func saveDeck()
    func saveCard()
}
