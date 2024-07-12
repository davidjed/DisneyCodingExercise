//
//  CharacterView.swift
//  MarvelCharacters
//
//  Created by David Jedeikin on 7/11/24.
//

import SwiftUI

struct CharacterView: View {
    @Environment(ContentViewModel.self) private var contentVM: ContentViewModel
    let character: MarvelCharacter
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: contentVM.detailBackgroundURL(for: character)))
                    .opacity(0.3)
                    .scaledToFill()
                    .frame(height: 500)
                
                VStack(alignment: .leading) {
                    Text(character.name.uppercased())
                        .font(.largeTitle)
                    HStack {
                        Image(systemName: "star")
                            .font(.title3)
                        Text("Follow Character".uppercased())
                            .font(.title3)
                    }
                    Spacer()
                }
            }
            
            if let comics = contentVM.characterComics[character.id] {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 40) {
                        ForEach(comics, id: \.id) { comic in
                            Button {
                            } label: {
                                VStack(alignment: .center) {
                                    AsyncImage(url: URL(string: contentVM.thumbnailURL(for: comic)))
                                        .frame(width: 168, height: 252)
                                        .scaledToFit()
                                    HStack {
                                        Text("\(comic.title)")
                                            .lineLimit(3)
                                            .font(.system(size: 14))
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Issue #\(comic.issueNumber)")
                                            .font(.system(size: 10))
                                        Spacer()
                                    }
                                    HStack {
                                        Text("\(contentVM.onSaleDate(for: comic))")
                                            .font(.system(size: 10))
                                        Spacer()
                                    }
                               }
                                .padding()
                            }
                            .padding()
                        }
                        .padding()
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .task {
            do {
                try await contentVM.loadComics(for: character.id)
                print("SUCCESS!")
            }
                catch(let err) {
                    print("ERR: \(err.localizedDescription)")
            }
        }
    }
}
