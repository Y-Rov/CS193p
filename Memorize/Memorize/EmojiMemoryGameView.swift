//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Admin on 2023-02-11.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            header
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card, gradient: game.themeColors)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
            footer
        }
        .padding(.horizontal)
    }
    
    var header: some View {
        HStack {
            Text("Score: " + String(game.playerScore))
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                game.start()
            }, label: {
                Text("New game")
            })
        }
    }
    
    var footer: some View {
        Text(game.themeName)
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    // Extra Credit 3
    let gradient: Gradient
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(gradient.stops.first!.color)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 180-90)).padding(4)
                        .foregroundColor(gradient.stops.first!.color)
                        .opacity(DrawingConstants.opacity)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    // Extra Credit 3
                    shape.fill(gradient)
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let opacity = 0.5
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let emojiGame = EmojiMemoryGame()
        emojiGame.choose(emojiGame.cards.first!)
        return EmojiMemoryGameView(game: emojiGame)
    }
}
