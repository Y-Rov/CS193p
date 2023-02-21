//
//  ContentView.swift
//  Memorize
//
//  Created by Admin on 2023-02-11.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))], spacing: 10) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                    }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let emojiGame = EmojiMemoryGame()
        ContentView(game: emojiGame)
            .previewDevice("iPhone 14")
            .preferredColorScheme(.light)
        ContentView(game: emojiGame)
            .previewDevice("iPhone 14 Plus")
            .preferredColorScheme(.light)
        ContentView(game: emojiGame)
            .previewDevice("iPhone 14 Pro")
            .preferredColorScheme(.dark)
        ContentView(game: emojiGame)
            .previewDevice("iPhone 14 Pro Max")
            .preferredColorScheme(.dark)
    }
}
