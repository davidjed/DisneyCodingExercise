//
//  MarvelCharactersApp.swift
//  MarvelCharacters
//
//  Created by David Jedeikin on 7/9/24.
//

import SwiftUI

@main
struct MarvelCharactersApp: App {
    
    @State private var contentVM: ContentViewModel = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(contentVM)
        }
    }
}
