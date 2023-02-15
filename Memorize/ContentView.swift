//
//  ContentView.swift
//  Memorize
//
//  Created by Admin on 2023-02-11.
//

import SwiftUI

struct ContentView: View {
    let game: EmojiMemoryGame
    
    var vehicles = ["🚄", "🚃", "🚠", "🚌", "🚎", "🚗", "🏎", "🏍", "🚑", "🚲", "🚂", "🛸", "🚁"]
    var buildings = ["🏠", "🏨", "💒", "🏣", "🏭", "🏪", "🏦", "🕌", "🏩", "🏛", "🏬", "🕍", "🏥", "⛩"]
    var food = ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍓", "🍒", "🥥", "🍑", "🍆", "🥑", "🥦", "🥕", "🥐"]
    var animals = ["🐍", "🦎", "🦖", "🐙", "🐳", "🐬", "🐊", "🐝", "🐴", "🐺", "🦇", "🦋", "🦆", "🦄", "🐉", "🐈"]
    
    @State var emojis = ["🚄", "🚃", "🚠", "🚌", "🚎", "🚗", "🏎", "🏍", "🚑", "🚲", "🚂", "🛸", "🚁"]
    
    @State var emojiCount = 4;
    let minEmojiCount = 4;
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .padding(.vertical)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
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
            Spacer()
            HStack {
                Spacer()
                vehicleThemeButton
                Spacer()
                buildingThemeButton
                Spacer()
                foodThemeButton
                Spacer()
                animalThemeButton
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    var vehicleThemeButton: some View {
        Button(action: {
            emojis = vehicles.shuffled()
            emojiCount = Int.random(in: minEmojiCount..<vehicles.count)
        }, label: {
            createButtonLabel(imageName: "car", caption: "Vehicles")
        })
    }
    
    var buildingThemeButton: some View {
        Button(action: {
            emojis = buildings.shuffled()
            emojiCount = Int.random(in: minEmojiCount..<buildings.count)
        }, label: {
            createButtonLabel(imageName: "house", caption: "Buildings")
        })
    }
    
    var foodThemeButton: some View {
        Button(action: {
            emojis = food.shuffled()
            emojiCount = Int.random(in: minEmojiCount..<food.count)
        }, label: {
            createButtonLabel(imageName: "fork.knife", caption: "Food")
        })
    }
    
    var animalThemeButton: some View {
        Button(action: {
            emojis = animals.shuffled()
            emojiCount = Int.random(in: minEmojiCount..<animals.count)
        }, label: {
            createButtonLabel(imageName: "pawprint", caption: "Animals")
        })
    }
    
    func createButtonLabel(imageName: String, caption: String) -> some View {
        VStack {
            Image(systemName: imageName)
                .font(.largeTitle)
            Text(caption)
                .font(.caption)
        }
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
//        ContentView(game: emojiGame)
//            .previewDevice("iPhone 14 Plus")
//            .preferredColorScheme(.light)
//        ContentView(game: emojiGame)
//            .previewDevice("iPhone 14 Pro")
//            .preferredColorScheme(.dark)
//        ContentView(game: emojiGame)
//            .previewDevice("iPhone 14 Pro Max")
//            .preferredColorScheme(.dark)
    }
}
