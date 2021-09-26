//
//  EmojiMemoryGame.swift
//  Memorise
//
//  Created by Philip Rose on 9/24/21.
//

import SwiftUI

class EmojiMemoryGame {
    static let emojis = ["✈️", "🚃", "🚗", "⛴", "🚛", "🚚", "🚙", "🚕", "🚓", "🏍", "🚲", "🛳", "🚢", "🚤", "⛵️", "🛶"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberofPairsOfCards: 4, createCardContent: { pairIndex in emojis[pairIndex] })
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
}
