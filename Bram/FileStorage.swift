//
//  FileStorage.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-01-04.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import RealmSwift

class FileStorage : Storage {
    
    // MARK: Variables
    let realm = try! Realm()
    
    // MARK: Storage
    
    public var decks: [Deck] {
        let results = realm.objects(Deck.self)
        var decks: [Deck] = []
        
        for deck in results {
            decks.append(deck)
        }
        
        return decks
    }
    
    func save(deck: Deck) {
        
    }
    
    func save(card: Card) {
        
    }
    
    // MARK: Helper Methods
}
