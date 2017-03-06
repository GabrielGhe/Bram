//
//  BramTests.swift
//  BramTests
//
//  Created by Gabriel Gheorghian on 2016-08-28.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import XCTest
import RealmSwift

@testable import Bram

class BramTests: XCTestCase {
    
    fileprivate var TEST_USER_ID = "TestId"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRename() {
        let newName = "newName"
        let deck = Deck(name: "oldName")
        deck.rename(deckName: newName)
        XCTAssertEqual(deck.name, newName, "Card should have been renamed")
    }
    
    func testAddCardToDeck() {
        let deck = Deck(name: "addCardDeck")
        let card = CardBuilder()
            .set(cardId: "1234")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .build()
        
        deck.add(card: card)
        XCTAssertEqual(deck.cards.count, 1, "Added a single card to deck")
    }
    
    func testCardMorePriorityThanOther() {
        let card1 = CardBuilder()
            .set(cardId: "1234")
            .set(question: "question")
            .set(userId: TEST_USER_ID)
            .set(answer: "answer 1")
            .build()
        
        let card2 = CardBuilder()
            .set(cardId: "2345")
            .set(userId: TEST_USER_ID)
            .set(question: "question 2")
            .set(answer: "answer 2")
            .set(dateToShow: Date().addDays(1))
            .build()
        XCTAssertTrue(card1 > card2, "Card 1 should have priority over card 2")
    }
    
    func testPeek() {
        let card1 = CardBuilder()
            .set(cardId: "1234")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .build()
        
        let card2 = CardBuilder()
            .set(userId: TEST_USER_ID)
            .set(cardId: "2345")
            .set(question: "question 2")
            .set(answer: "answer 2")
            .set(dateToShow: Date().addDays(1))
            .build()
        
        var queue = PriorityQueue<Card>(ascending: false)
        
        queue.push(card1)
        queue.push(card2)
        
        XCTAssertTrue(queue.peek() == card1, "Card 1 should be the card that pops up first")
    }
    
    func testGetCardsDue() {
        let card1 = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .build()
        
        let card2 = CardBuilder()
            .set(otherCard: card1)
            .set(cardId: "2")
            .set(userId: TEST_USER_ID)
            .set(dateToShow:Date().addDays(1))
            .build()
        
        let card3 = CardBuilder()
            .set(otherCard: card1)
            .set(cardId: "3")
            .set(userId: TEST_USER_ID)
            .set(dateToShow:Date().addDays(1))
            .build()
        
        let card4 = CardBuilder()
            .set(otherCard: card1)
            .set(cardId: "4")
            .set(userId: TEST_USER_ID)
            .set(dateToShow:Date().addDays(2))
            .build()
        
        let deck: Deck = Deck(name: "Test1")
        deck.add(cards: [card1, card2, card3, card4])
        XCTAssertEqual(deck.getCardsDueBy().count, 3, "There should only be 3 cards due today")
    }
    
    func testTimeDifference() {
        let today = Date()
        let todayLater = Date().e
        let oneDay = Date().addDays(1)
        let twoDays = Date().addDays(2)
        let tenDays = Date().addDays(10)
        
        assert(Date.isSmallerThan(today, oneDay), "today should be within the range")
        assert(Date.isSmallerThan(today, todayLater), "today should be within the range")
        assert(Date.isSmallerThan(oneDay, twoDays), "oneDay should be within the range")
        assert(!Date.isSmallerThan(tenDays, today), "tenDays should not be within the range")
        assert(Date.isSmallerThan(today, tenDays), "today should be within the range")
        assert(!Date.isSmallerThan(oneDay, today), "oneDay should not be within the range")
        assert(!Date.isSmallerThan(twoDays, today), "twoDay should not be within the range")
    }
    
    func testScheduleShortWaitBad() {
        let delay = 1
        var card = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .build()
        
        card = Scheduler.scheduleShowTime(card: card, answer: TimeAdded.BAD)
        let deck = Deck(name: "Deck1")
        deck.add(cards: [card])
        let cardsToday = deck.getCardsDueBy(Date.s.addDays(delay))
        XCTAssertEqual(cardsToday.count, 1, "The card should be due")
        XCTAssertEqual(cardsToday[0].dateToShow.s, Date().addDays(delay).s, "The card should be due")
    }
    
    func testScheduleShortWaitOk() {
        let delay = 2
        var card = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .build()
        
        card = Scheduler.scheduleShowTime(card: card, answer: TimeAdded.OK)
        let deck = Deck(name: "Deck1")
        deck.add(cards: [card])
        let cardsToday = deck.getCardsDueBy(Date.s.addDays(delay))
        XCTAssertEqual(cardsToday.count, 1, "The card should be due")
        XCTAssertEqual(cardsToday[0].dateToShow.s, Date().addDays(delay).s, "The card should be due")
    }
    
    func testScheduleShortWaitGreat() {
        let delay = 3
        var card = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .build()
        
        card = Scheduler.scheduleShowTime(card: card, answer: TimeAdded.GREAT)
        let deck = Deck(name: "Deck1")
        deck.add(cards: [card])
        let cardsToday = deck.getCardsDueBy(Date.s.addDays(delay))
        XCTAssertEqual(cardsToday.count, 1, "The card should be due")
        XCTAssertEqual(cardsToday[0].dateToShow.s, Date().addDays(delay).s, "The card should be due")
    }
    
    func testScheduleLongWaitBad() {
        let daysWait = 1
        var card = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .set(daysToWait:5)
            .build()
        
        card = Scheduler.scheduleShowTime(card: card, answer: TimeAdded.BAD)
        XCTAssertEqual(card.daysToWait, daysWait, "The card should wait for \(daysWait) days")
        
        let deck = Deck(name: "Deck1")
        deck.add(cards: [card])
        let cardsToday = deck.getCardsDueBy(Date.s.addDays(daysWait))
        XCTAssertEqual(cardsToday.count, 1, "The card should be due")
        XCTAssertEqual(cardsToday[0].dateToShow.s, Date().addDays(daysWait).s, "The card should be due")
    }
    
    func testScheduleLongWaitOk() {
        let daysWait = 6
        var card = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .set(daysToWait:5)
            .build()
        
        card = Scheduler.scheduleShowTime(card: card, answer: TimeAdded.OK)
        XCTAssertEqual(card.daysToWait, daysWait, "The card should wait for \(daysWait) days")
        
        let deck = Deck(name: "Deck1")
        deck.add(cards: [card])
        let cardsToday = deck.getCardsDueBy(Date.s.addDays(daysWait))
        XCTAssertEqual(cardsToday.count, 1, "The card should be due")
        XCTAssertEqual(cardsToday[0].dateToShow.s, Date().addDays(daysWait).s, "The card should be due")
    }
    
    func testScheduleLongWaitGreat() {
        let daysWait = 10
        var card = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer:  "answer 1")
            .set(daysToWait:5)
            .build()
        
        card = Scheduler.scheduleShowTime(card: card, answer: TimeAdded.GREAT)
        XCTAssertEqual(card.daysToWait, daysWait, "The card should wait for \(daysWait) days")
        
        let deck = Deck(name: "Deck1")
        deck.add(cards: [card])
        let cardsToday = deck.getCardsDueBy(Date.s.addDays(daysWait))
        XCTAssertEqual(cardsToday.count, 1, "The card should be due")
        XCTAssertEqual(cardsToday[0].dateToShow.s, Date().addDays(daysWait).s, "The card should be due")
    }
    
    func testCardsSomeOverdue() {
        let card = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .set(dateToShow:Date.s.addDays(-2))
            .build()
        
        let deck = Deck(name: "Deck1")
        deck.add(cards: [card])
        let cardsToday = deck.getCardsDueBy(Date.s)
        XCTAssertEqual(cardsToday.count, 1, "The card should be due")
    }
    
    func testCardsOnTime() {
        let card = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .build()
        
        let deck = Deck(name: "Deck1")
        deck.add(cards: [card])
        let cardsToday = deck.getCardsDueBy(Date.s)
        XCTAssertEqual(cardsToday.count, 1, "The card should be due")
    }
    
    func testCardsNoneToShow() {
        let card = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .set(dateToShow:Date.s.addDays(10))
            .build()
        
        let deck = Deck(name: "Deck1")
        deck.add(cards: [card])
        let cardsToday = deck.getCardsDueBy(Date.s)
        XCTAssertEqual(cardsToday.count, 0, "The card should be due")
    }
    
    func testUpdateCard() {
        var card1 = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .set(daysToWait:5)
            .build()
        
        let deck = Deck(name: "TestDeck")
        deck.add(cards: [card1])
        card1 = Scheduler.scheduleShowTime(card: card1, answer: .GREAT)
        deck.update(card: card1)
        XCTAssertEqual(card1.daysToWait, deck.get(cardId: card1.cardId)!.daysToWait, "Should have updated card")
    }
    
    func testGetRelated() {
        let card1 = CardBuilder()
            .set(cardId: "1")
            .set(userId: TEST_USER_ID)
            .set(question: "question 1")
            .set(answer: "answer 1")
            .set(dateToShow:Date().addDays(2).e)
            .set(daysToWait:2)
            .build()
        
        let card2 = CardBuilder()
            .set(otherCard: card1)
            .set(cardId: "2")
            .build()
        
        let card3 = CardBuilder()
            .set(otherCard: card1)
            .set(cardId: "3")
            .build()
        
        let cards = List<CardDue>()
        cards.append(CardDue(card: card1))
        cards.append(CardDue(card: card2))
        cards.append(CardDue(card: card3))
        
        let card4 = CardBuilder()
            .set(otherCard: card1)
            .set(cardId: "4")
            .set(associatedCards:cards)
            .set(daysToWait:0)
            .set(dateToShow:Date())
            .build()
        
        let deck = Deck(name: "test2")
        deck.add(cards: [card1, card2, card3, card4])
        let cardsToDo = deck.getCardsDueBy()
        XCTAssertEqual(cardsToDo.count, 1, "Only card4")
    }
    
    func testSearchQuestion() {
        var ctr = 0
        let card0 = CardBuilder()
            .set(cardId: "\(ctr)")
            .set(userId: TEST_USER_ID)
            .set(question: "question \(ctr) thingy")
            .set(answer: "answer \(ctr)")
            .build()
        
        ctr += 1
        let card1 = CardBuilder()
            .set(userId: TEST_USER_ID)
            .set(cardId: "\(ctr)")
            .set(question: "question \(ctr)")
            .set(answer: "answer \(ctr)")
            .build()
        
        ctr += 2
        let card2 = CardBuilder()
            .set(userId: TEST_USER_ID)
            .set(cardId: "\(ctr)")
            .set(question: "question \(ctr)")
            .set(answer: "answer \(ctr)")
            .build()
        
        let deck = Deck(name: "testSearch")
        deck.add(cards: [card0, card1, card2])
        
        let searchQuery = "thingy"
        let searchResults = deck.search(text: searchQuery)
        XCTAssertEqual(searchResults.count, 1, "Only card0 should be returned")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
