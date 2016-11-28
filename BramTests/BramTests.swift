//
//  BramTests.swift
//  BramTests
//
//  Created by Gabriel Gheorghian on 2016-08-28.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import XCTest
import SwiftPriorityQueue
@testable import Bram

class BramTests: XCTestCase {
    
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
        let card = Card.Builder()
            .setCardId("1234")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        deck.add(card: card)
        XCTAssertEqual(deck.cards.count, 1, "Added a single card to deck")
    }
    
    func testCardMorePriorityThanOther() {
        let card1 = Card.Builder()
            .setCardId("1234")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        let card2 = Card.Builder()
            .setCardId("2345")
            .setQuestion("question 2")
            .setAnswer("answer 2")
            .setDateToShow(Date().addDays(1))
            .build()
        XCTAssertTrue(card1 > card2, "Card 1 should have priority over card 2")
    }
    
    func testPeek() {
        let card1 = Card.Builder()
            .setCardId("1234")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        let card2 = Card.Builder()
            .setCardId("2345")
            .setQuestion("question 2")
            .setAnswer("answer 2")
            .setDateToShow(Date().addDays(1))
            .build()
        
        var queue = PriorityQueue<Card>(ascending: false)
        
        queue.push(card1)
        queue.push(card2)
        
        XCTAssertTrue(queue.peek() == card1, "Card 1 should be the card that pops up first")
    }
    
    func testGetCardsDue() {
        let card1 = Card.Builder()
            .setCardId("1")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        let card2 = Card.Builder()
            .setCard(card1)
            .setCardId("2")
            .setDateToShow(Date().addDays(1))
            .build()
        
        let card3 = Card.Builder()
            .setCard(card1)
            .setCardId("3")
            .setDateToShow(Date().addDays(1))
            .build()
        
        let card4 = Card.Builder()
            .setCard(card1)
            .setCardId("4")
            .setDateToShow(Date().addDays(2))
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
    
    func testGetCardsDueScheduleOverDue() {
        var card1 = Card.Builder()
            .setCardId("1")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        var card2 = Card.Builder()
            .setCard(card1)
            .setCardId("2")
            .build()
        
        
    }
    
    func testGetCardsDueScheduleNone() {
        var card1 = Card.Builder()
            .setCardId("1")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        var card2 = Card.Builder()
            .setCard(card1)
            .setCardId("2")
            .build()
    }
    
    func testGetCardsDueScheduleSome() {
        var card1 = Card.Builder()
            .setCardId("1")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        var card2 = Card.Builder()
            .setCard(card1)
            .setCardId("2")
            .build()
    }
    
    func testGetCardsDueScheduleOne() {
        var card1 = Card.Builder()
            .setCardId("1")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        var card2 = Card.Builder()
            .setCard(card1)
            .setCardId("2")
            .build()
    }
    
    func testGetCardsDueSchedule() {
        var card1 = Card.Builder()
            .setCardId("1")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        var card2 = Card.Builder()
            .setCard(card1)
            .setCardId("2")
            .build()
        
        var card3 = Card.Builder()
            .setCard(card1)
            .setCardId("3")
            .build()
        
        var card4 = Card.Builder()
            .setCard(card1)
            .setCardId("4")
            .build()
        
        var card5 = Card.Builder()
            .setCard(card1)
            .setCardId("5")
            .setDaysToWait(5)
            .build()
        
        var card6 = Card.Builder()
            .setCard(card1)
            .setCardId("6")
            .setDaysToWait(5)
            .build()
        
        var card7 = Card.Builder()
            .setCard(card1)
            .setCardId("7")
            .setDaysToWait(5)
            .build()
        
        var card8 = Card.Builder()
            .setCard(card1)
            .setCardId("8")
            .setDaysToWait(5)
            .build()
        
        card1 = Scheduler.scheduleShowTime(card: card1, answer: TimeAdded.BAD)
        card2 = Scheduler.scheduleShowTime(card: card2, answer: TimeAdded.OK)
        card4 = Scheduler.scheduleShowTime(card: card4, answer: TimeAdded.GREAT)
        
        card5 = Scheduler.scheduleShowTime(card: card5, answer: TimeAdded.BAD)
        card6 = Scheduler.scheduleShowTime(card: card6, answer: TimeAdded.OK)
        card8 = Scheduler.scheduleShowTime(card: card8, answer: TimeAdded.GREAT)
        
        let deck = Deck(name: "Deck1")
        deck.add(cards: [card1, card2, card3, card4, card5, card6, card7, card8])
        
        let cards1day = deck.getCardsDueBy(Date.s.addDays(1))
        for cardDue in cards1day {
            deck.delete(cardId: cardDue.cardId)
        }
        
        let cards2days = deck.getCardsDueBy(Date.s.addDays(2))
        for cardDue in cards2days {
            deck.delete(cardId: cardDue.cardId)
        }
        
        let cards3days = deck.getCardsDueBy(Date.s.addDays(3))
        for cardDue in cards3days {
            deck.delete(cardId: cardDue.cardId)
        }
        
        let cards6days = deck.getCardsDueBy(Date.s.addDays(6))
        for cardDue in cards6days {
            deck.delete(cardId: cardDue.cardId)
        }
        
        let cards8days = deck.getCardsDueBy(Date.s.addDays(8))
        for cardDue in cards8days {
            deck.delete(cardId: cardDue.cardId)
        }
        
        let cards10days = deck.getCardsDueBy(Date.s.addDays(10))
        
        XCTAssert(Date.isSmallerThan(card1.dateToShow, Date.s.addDays(1)), String(card1.daysToWait))
        XCTAssert(!Date.isSmallerThan(card2.dateToShow, Date.s.addDays(1)), String(card2.daysToWait))
        XCTAssert(!Date.isSmallerThan(card3.dateToShow, Date.s.addDays(1)), String(card3.daysToWait))
        XCTAssert(Date.isSmallerThan(card5.dateToShow, Date.s.addDays(1)), String(card5.daysToWait))
        
        XCTAssertEqual(cards1day.count, 2, "There should be two cards for tomorrow, 1 and 5")
        XCTAssertEqual(cards2days.count, 2, "There should be two cards for 2 days from now, 2 and 3")
        XCTAssertEqual(cards3days.count, 1, "There should be one card for 3 days from now")
        XCTAssertEqual(cards6days.count, 1, "There should be one card for 6 days from now")
        XCTAssertEqual(cards8days.count, 1, "There should be one card for 8 days from now")
        XCTAssertEqual(cards10days.count, 1, "There should be one card for 10 days from now")
    }
    
    func testUpdateCard() {
        var card1 = Card.Builder()
            .setCardId("1")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .setDaysToWait(5)
            .build()
        
        let deck = Deck(name: "TestDeck")
        deck.add(cards: [card1])
        card1 = Scheduler.scheduleShowTime(card: card1, answer: .GREAT)
        deck.update(card: card1)
        XCTAssertEqual(card1.daysToWait, deck.get(cardId: card1.cardId)!.daysToWait, "Should have updated card")
    }
    
    func testGetRelated() {
        let card1 = Card.Builder()
            .setCardId("1")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .setDateToShow(Date().addDays(2).e)
            .setDaysToWait(2)
            .build()
        
        let card2 = Card.Builder()
            .setCard(card1)
            .setCardId("2")
            .build()
        
        let card3 = Card.Builder()
            .setCard(card1)
            .setCardId("3")
            .build()
        
        let card4 = Card.Builder()
            .setCard(card1)
            .setCardId("4")
            .setAssociatedCards([card1.cardId, card2.cardId, card3.cardId])
            .setDaysToWait(0)
            .setDateToShow(Date())
            .build()
        
        let deck = Deck(name: "test2")
        deck.add(cards: [card1, card2, card3, card4])
        let cardsToDo = deck.getCardsDueBy()
        XCTAssertEqual(cardsToDo.count, 1, "Only card4")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
