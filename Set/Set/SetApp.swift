//
//  SetApp.swift
//  Set
//
//  Created by user on 3/11/23.
//

import SwiftUI

@main
struct SetApp: App {
    let setGame = SetStandardGame()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(game: setGame)
        }
    }
}
