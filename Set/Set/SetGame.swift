//
//  SetGame.swift
//  Set
//
//  Created by user on 3/12/23.
//

import Foundation

struct SetGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var currentSetState: SetState?
    private var selectedIndices: [Int] = []
    
    init(numberOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfCards {
            let content = createCardContent(index)
            cards.append(Card(content: content, id: index))
        }
    }
    
    mutating func addThreeMoreCards(from additionalCards: ArraySlice<CardContent>) {
        for card in additionalCards {
            cards.append(Card(content: card, id: cards.count))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            switch currentSetState {
            case .none:
                selectedIndices.append(chosenIndex)
                cards[chosenIndex].isIncludedInSet = true
                currentSetState = .initial
            case .initial:
                if !selectedIndices.contains(where: { $0 == chosenIndex }) {
                    selectedIndices.append(chosenIndex)
                    cards[chosenIndex].isIncludedInSet = true
                    currentSetState = .intermediate
                } else {
                    let index = selectedIndices.popLast()!
                    cards[index].isIncludedInSet = false
                    currentSetState = nil
                }
            case .intermediate:
                if !selectedIndices.contains(where: { $0 == chosenIndex }) {
                    selectedIndices.append(chosenIndex)
                    cards[chosenIndex].isIncludedInSet = true
                    currentSetState = .final
                    checkSetMatchingCards()
                } else {
                    let index = selectedIndices.popLast()!
                    cards[index].isIncludedInSet = false
                    currentSetState = .initial
                }
            case .final:
                break
            }
        }
    }
    
    private mutating func checkSetMatchingCards() {
        if cards[selectedIndices[0]].content == cards[selectedIndices[1]].content &&
            cards[selectedIndices[1]].content == cards[selectedIndices[2]].content
        {
            cards[selectedIndices[0]].isMatched = true
            cards[selectedIndices[1]].isMatched = true
            cards[selectedIndices[2]].isMatched = true
        }
    }
    
    struct Card: Identifiable {
        var isIncludedInSet: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        let id: Int
    }
}
