//
//  ContentView.swift
//  Memorise
//
//  Created by Philip Rose on 9/14/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private func getColourForScore(_ score: Int) -> Color {
        switch score {
        case let score where score > 0:
            return Color.green
        case let score where score < 0:
            return Color.red
        default:
            return Color.primary
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Button("New Game") {
                        viewModel.newGame()
                    }.font(.subheadline)
                }
                HStack {
                    VStack {
                        Text("Memorise").font(.headline)
                        Text("\(viewModel.themeName)")
                            .font(.subheadline)
                            .foregroundColor(viewModel.cardColour)
                    }
                    
                }
            }
            Divider()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75, maximum: 200))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
                .foregroundColor(viewModel.cardColour)
            }
            Divider()
            VStack {
                Text("Score").font(.subheadline)
                Text(String(viewModel.score))
                    .font(.system(size: 64))
                    .foregroundColor(getColourForScore(viewModel.score))
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
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
        let game = EmojiMemoryGame()
        
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
