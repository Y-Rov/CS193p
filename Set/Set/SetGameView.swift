//
//  SetGameView.swift
//  Set
//
//  Created by user on 3/11/23.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetStandardGame
    
    var body: some View {
        VStack {
            header
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(4)
            }
        }
        .padding(.horizontal)
    }
    
    var header: some View {
        HStack {
            Button(action: {
                //game.start()
            }, label: {
                Text("Deal 3 More Cards")
            })
            Spacer()
            Button(action: {
                game.start()
            }, label: {
                Text("New Game")
            })
        }
    }
}

struct CardView: View {
    let card: SetStandardGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.shadow(color: .black, radius: 1, x: 0, y: 2)
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(.gray)
                Text(card.content.color)
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 1
        static let fontScale: CGFloat = 0.7
        static let opacity = 0.5
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let setGame = SetStandardGame()
        SetGameView(game: setGame)
    }
}
