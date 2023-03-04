//
//  GameTheme.swift
//  Memorize
//
//  Created by user on 2/21/23.
//

import Foundation

struct MemorizeTheme {
    init(name: String, emojis: Array<String>, numberOfPairsOfCards: Int, colors: [String]) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairsOfCards = numberOfPairsOfCards
        self.colors = colors
    }
    
    // Extra Credit 1-2
    init(name: String, emojis: Array<String>, isNumberOfPairsOfCardsRandom: Bool = false, colors: [String]) {
        self.name = name
        self.emojis = emojis
        self.isNumberOfPairsOfCardsRandom = isNumberOfPairsOfCardsRandom
        numberOfPairsOfCards = isNumberOfPairsOfCardsRandom ? Int.random(in: minNumberOfPairsOfCards...emojis.count) : emojis.count
        self.colors = colors
    }
    
    var name: String
    var emojis: Array<String>
    var numberOfPairsOfCards: Int
    // Extra Credit 3
    var colors: [String]
    
    var isNumberOfPairsOfCardsRandom: Bool = false
    let minNumberOfPairsOfCards: Int = 2
}
