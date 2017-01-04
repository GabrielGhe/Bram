//
//  Storage.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-12-29.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

protocol Storage {
    var decks: [Deck] { get }
    func save(deck: Deck)
    func save(card: Card)
}
