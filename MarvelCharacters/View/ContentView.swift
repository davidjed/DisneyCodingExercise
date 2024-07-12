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
            VStack {
                HStack {
                    Text("POPULAR CHARACTERS")
                        .font(.system(size: 36, weight: .bold))
                    Spacer()
                    Button {
                    } label: {
                        HStack {
                            Text("SEE ALL")
                                .font(.system(size: 20))
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20))
                                .padding(.leading, -30)
                        }
                    }
                }
                .padding()
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(contentVM.characters, id: \.id) { character in
                            NavigationLink(destination: CharacterView(character: character)) {
                                VStack {
                                    AsyncImage(url: URL(string: contentVM.thumbnailURL(for: character))) { result in
                                        result.image?
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    .frame(width: 350, height: 225)
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    Text("\(character.name.uppercased())")
                                        .multilineTextAlignment(.center)
                                        .frame(width: 350)
                                }
                                .frame(width: 400, height: 350)
                                .padding()
                            }
                            .padding()
                        }
                    }
                }
                .task {
                    do {
                        try await contentVM.loadPopularCharacters()
                    }
                        catch(let err) {
                            print("ERR: \(err.localizedDescription)")
                    }
                }
            }
            
        }
        .padding()
    }
}
