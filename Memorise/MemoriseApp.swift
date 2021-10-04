//
//  MemoriseApp.swift
//  Memorise
//
//  Created by Philip Rose on 9/14/21.
//

import SwiftUI

@main
struct MemoriseApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
