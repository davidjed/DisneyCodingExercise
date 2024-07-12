//
//  ContentView.swift
//  MarvelCharacters
//
//  Created by David Jedeikin on 7/9/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(ContentViewModel.self) private var contentVM: ContentViewModel

    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(contentVM.characters, id: \.id) { character in
                        NavigationLink(destination: CharacterView(character: character)) {
                            VStack {
                                AsyncImage(url: URL(string: contentVM.thumbnailURL(for: character)))
                                    .frame(width: 150, height: 225)
                                    .scaledToFit()
                                    .clipShape(Circle())
                                Text("\(character.name.uppercased())")
                                    .multilineTextAlignment(.center)
                                    .frame(width: 225)
                            }
                            .frame(width: 350, height: 350)
                            .padding()
                        }
                        .padding()
                    }
                }
            }
            .task {
                do {
                    try await contentVM.loadPopularCharacters()
                    print("SUCCESS!")
                }
                    catch(let err) {
                        print("ERR: \(err.localizedDescription)")
                }
            }
        }
        .padding()
    }
}
