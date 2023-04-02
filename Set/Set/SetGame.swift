//
//  SetGame.swift
//  Set
//
//  Created by user on 3/12/23.
//

import Foundation

struct SetGame {
    private(set) var cards: Array<Card> = []
    private var selectedIndices: [Int] = []
    private(set) var deck: Array<SetStandardCardContent>
    
    private(set) var currentGameState: GameState?
    private var idIncrementValue: Int
    
    init(numberOfCards: Int, deck: Array<SetStandardCardContent>, createCardContent: (Int) -> SetStandardCardContent) {
        selectedIndices.reserveCapacity(3)
        self.deck = deck
        self.deck.removeSubrange(0..<numberOfCards)
        idIncrementValue = numberOfCards
        for index in 0..<numberOfCards {
            let content = createCardContent(index)
            cards.append(Card(content: content, id: index))
        }
    }
    
    mutating func addThreeMoreCards() -> Bool {
        let randomIndex = Int.random(in: 0...deck.count - 3)
        deck[randomIndex..<randomIndex + 3].forEach {
            cards.append(Card(content: $0, id: idIncrementValue))
            idIncrementValue += 1
        }
        deck.removeSubrange(randomIndex..<randomIndex + 3)
        return deck.isEmpty
    }
    
    private mutating func replaceMatchedCards() {
        if idIncrementValue < deck.count {
//            let randomIndex = Int.random(in: 0...deck.count - 3)
//            var i = 0
//            deck[randomIndex..<randomIndex + 3].forEach {
//                cards[selectedIndices[i]].isIncludedInSet = false
//                cards[selectedIndices[i]].state = .initial
//                cards[selectedIndices[i]].content = $0
//                i += 1
//            }
//            deck.removeSubrange(randomIndex..<randomIndex + 3)
            let randomIndex = idIncrementValue
            var i = 0
            deck[randomIndex..<randomIndex + 3].forEach {
                cards[selectedIndices[i]].isIncludedInSet = false
                cards[selectedIndices[i]].state = .initial
                cards[selectedIndices[i]].content = $0
                i += 1
            }
            //deck.removeSubrange(randomIndex..<randomIndex + 3)
            idIncrementValue += 3
        } else {
            cards.removeAll(where: { $0.state == .final })
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            switch currentGameState {
            case .none:
                selectedIndices.append(chosenIndex)
                cards[chosenIndex].isIncludedInSet = true
                currentGameState = .initial
            case .initial:
                if !selectedIndices.contains(chosenIndex) {
                    selectedIndices.append(chosenIndex)
                    cards[chosenIndex].isIncludedInSet = true
                    currentGameState = .intermediate
                } else {
                    selectedIndices.removeAll(where: { $0 == chosenIndex })
                    cards[chosenIndex].isIncludedInSet = false
                    currentGameState = nil
                }
            case .intermediate:
                if !selectedIndices.contains(chosenIndex) {
                    selectedIndices.append(chosenIndex)
                    cards[chosenIndex].isIncludedInSet = true
                    currentGameState = .final
                    checkSetMatchingCards()
                } else {
                    selectedIndices.removeAll(where: { $0 == chosenIndex })
                    cards[chosenIndex].isIncludedInSet = false
                    currentGameState = .initial
                }
            case .final:
                if cards[selectedIndices[0]].state == .intermediate {
                    selectedIndices.forEach {
                        cards[$0].isIncludedInSet = false
                        cards[$0].state = .initial
                    }
                    selectedIndices.removeAll(keepingCapacity: true)
                    selectedIndices.append(chosenIndex)
                    cards[chosenIndex].isIncludedInSet = true
                    currentGameState = .initial
                } else if cards[selectedIndices[0]].state == .final {
                    replaceMatchedCards()
                    if !selectedIndices.contains(chosenIndex) {
                        selectedIndices.removeAll(keepingCapacity: true)
                        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
                            selectedIndices.append(chosenIndex)
                            cards[chosenIndex].isIncludedInSet = true
                            currentGameState = .initial
                        }
                    } else {
                        selectedIndices.removeAll(keepingCapacity: true)
                        currentGameState = .none
                    }
                }
            }
        }
    }
        
    private mutating func checkSetMatchingCards() {
        let isMatch = cards[selectedIndices[0]].content.checkIfCardsMakeSet(second: cards[selectedIndices[1]].content, third: cards[selectedIndices[2]].content)
        selectedIndices.forEach { cards[$0].state = isMatch ? .final : .intermediate }
    }
    
    struct Card: Identifiable {
        var isIncludedInSet: Bool = false
        var state: GameState = .initial
        var content: SetStandardCardContent
        let id: Int
    }
    
    enum GameState {
        case initial
        case intermediate
        case final
    }
}
