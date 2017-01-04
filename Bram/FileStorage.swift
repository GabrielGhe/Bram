//
//  FileStorage.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-01-04.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import RealmSwift

class FileStorage : Storage {
    fileprivate let realm = try! Realm()
    fileprivate var internalDecks:[Deck] = []
    
    public var decks: [Deck] {
        return internalDecks
    }
    
    func save(deck: Deck) {
        
    }
    
    func save(card: Card) {
        
    }
}
