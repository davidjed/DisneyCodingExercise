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
                AsyncImage(url: URL(string: contentVM.detailBackgroundURL(for: character))) { result in
                    result.image?
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: 600, height: 500)
                .opacity(0.3)
                .padding()
                
                VStack(alignment: .leading) {
                    Text(character.name.uppercased())
                        .font(.system(size: 36, weight: .bold))
                    HStack {
                        Image(systemName: "star")
                            .font(.system(size: 20))
                            .padding(.trailing, -30)
                        Text("Follow Character".uppercased())
                            .font(.system(size: 20))
                            .padding(.leading, -30)
                        Spacer()
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
                                    AsyncImage(url: URL(string: contentVM.thumbnailURL(for: comic))) { result in
                                        result.image?
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    .frame(width: 168, height: 252)
                                    HStack {
                                        Text("\(comic.title)")
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
            }
            catch(let err) {
                print("ERR: \(err.localizedDescription)")
            }
        }
    }
}
