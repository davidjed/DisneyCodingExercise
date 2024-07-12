//
//  MarvelCharacters.swift
//  MarvelCharacters
//
//  Created by David Jedeikin on 7/10/24.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    let code: Int
    let status: String
    let data: T
}

struct MarvelResults<R: Codable>: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [R]
}

struct MarvelCharacter: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail

    static func == (lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MarvelComic: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let issueNumber: Int
    let thumbnail: Thumbnail
    let dates: [ComicDate]

    static func == (lhs: MarvelComic, rhs: MarvelComic) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ComicDate: Codable {
    let type: String
    let date: String
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
}
