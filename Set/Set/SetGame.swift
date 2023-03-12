//
//  SetGame.swift
//  Set
//
//  Created by user on 3/12/23.
//

import Foundation

struct SetGame<CardContent> {
    private(set) var gameCards: Array<Card>
    
    init(numberOfCards: Int, createCardContent: (Int) -> CardContent) {
        gameCards = []
        for index in 0..<numberOfCards {
            let content = createCardContent(index)
            gameCards.append(Card(content: content, id: index))
        }
    }
    
    mutating func addThreeMoreCards(from cards: ArraySlice<CardContent>) {
        
    }
    
    struct Card: Identifiable {
        
        let content: CardContent
        let id: Int
    }
}
