//
//  SetStandardGame.swift
//  Set
//
//  Created by user on 3/12/23.
//

import SwiftUI

class SetStandardGame: ObservableObject {
    typealias Card = SetGame<SetCardContent>.Card
    
    
    private static let numbersOfShapes = 1...3
    private static let shapes = ["diamond", "squiggle", "oval"]
    private static let shadings = ["solid", "striped", "open"]
    private static let colors = ["red", "green", "purple"]
    
    private var deck: Array<SetCardContent>
    @Published private var model: SetGame<SetCardContent>
    
    private static func createSetGame(with firstTwelveCards: ArraySlice<SetCardContent>) -> SetGame<SetCardContent> {
        SetGame<SetCardContent>(numberOfCards: GameConstants.startCardsQuantity) { index in
            firstTwelveCards[index]
        }
    }
    
    init() {
        var preparationDeck: Array<SetCardContent> = []
        preparationDeck.reserveCapacity(GameConstants.allCardsQuantity)
        for number in SetStandardGame.numbersOfShapes {
            for shape in SetStandardGame.shapes {
                for shading in SetStandardGame.shadings {
                    for color in SetStandardGame.colors {
                        preparationDeck.append(SetCardContent(numberOfShapes: number, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        let shuffledDeck = preparationDeck.shuffled()
        deck = shuffledDeck
        model = SetStandardGame.createSetGame(with: shuffledDeck[0..<GameConstants.startCardsQuantity])
    }
    
    var cards: Array<Card> {
        model.gameCards
    }
    
    // MARK: Intents
    func start() {
        deck.shuffle()
        model = SetStandardGame.createSetGame(with: deck[0..<GameConstants.startCardsQuantity])
    }
    
    func dealThreeMoreCards() {
        let randomIndex = Int.random(in: 0...deck.count - 3)
        model.addThreeMoreCards(from: deck[randomIndex..<randomIndex + 3])
    }
    
    private struct GameConstants {
        static let allCardsQuantity = 81
        static let startCardsQuantity = 12
    }
}
