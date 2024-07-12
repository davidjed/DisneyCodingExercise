//
//  ContentViewModel.swift
//  MarvelCharacters
//
//  Created by David Jedeikin on 7/10/24.
//

import Foundation

@Observable class ContentViewModel {
    let apiClient = APIClient()
    
    var characters: [MarvelCharacter] = []
    var characterComics: [Int: [MarvelComic]] = [:]
    
    func loadPopularCharacters() async throws {
        let characterWrapper = try await self.apiClient.getPopularCharacters()
        self.characters = characterWrapper?.data.results ?? []
    }
    
    func loadComics(for characterId: Int) async throws {
        if self.characterComics[characterId] == nil {
            let comicWrapper = try await self.apiClient.getCharacterComics(for: characterId)
            self.characterComics[characterId] = comicWrapper?.data.results ?? []
        }
    }
    
    func thumbnailURL(for character: MarvelCharacter) -> String {
        //http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73/portrait_xlarge.jpg
        let httpsPath = character.thumbnail.path.replacingOccurrences(of: "http:", with: "https:")
        let urlStr = httpsPath + "/portrait_xlarge." + character.thumbnail.extension
        
        return urlStr
    }
    
    func thumbnailURL(for comic: MarvelComic) -> String {
        //http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73/portrait_fantastic.jpg
        let httpsPath = comic.thumbnail.path.replacingOccurrences(of: "http:", with: "https:")
        let urlStr = httpsPath + "/portrait_fantastic." + comic.thumbnail.extension
        
        return urlStr
    }
    
    func onSaleDate(for comic: MarvelComic) -> String {
        if let onSaleDate = comic.dates.first(where: { $0.type == "onsaleDate" }) {
            // this could probably be better handled with JSON date decoding
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from: onSaleDate.date) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "MMM d, yyyy"
                return outputFormatter.string(for: date) ?? onSaleDate.date
            }

            return onSaleDate.date
        }
        return "Unknown"
    }

    func detailBackgroundURL(for character: MarvelCharacter) -> String {
        //http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73/detail.jpg
        let httpsPath = character.thumbnail.path.replacingOccurrences(of: "http:", with: "https:")
        let urlStr = httpsPath + "/detail." + character.thumbnail.extension
        
        return urlStr
    }
}
