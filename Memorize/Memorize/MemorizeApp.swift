//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Admin on 2023-02-11.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let emojiGame = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: emojiGame)
        }
    }
}
