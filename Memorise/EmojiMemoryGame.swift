//
//  EmojiMemoryGame.swift
//  Memorise
//
//  Created by Philip Rose on 9/24/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["✈️", "🚃", "🚗", "⛴", "🚛", "🚚", "🚙", "🚕", "🚓", "🏍", "🚲", "🛳", "🚢", "🚤", "⛵️", "🛶"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberofPairsOfCards: 6, createCardContent: { pairIndex in emojis[pairIndex] })
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: [Card] {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
