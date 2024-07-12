//
//  APIClient.swift
//  MarvelCharacters
//
//  Created by David Jedeikin on 7/9/24.
//

import Foundation

class APIClient {
    let baseURL = "https://gateway.marvel.com:443"
    let apiKey = "9b134f7ef8965bc14e25dafe3004d027"
    let privateKey = "28655feffa7f74dddeb7e992956adc445cd41aee"
    
    func getPopularCharacters() async throws -> MarvelResponse<MarvelResults<MarvelCharacter>>? {
        guard let request = asGetRequest(baseURL: self.baseURL, endpoint: "/v1/public/characters", queryParams: [:]) else { return nil }
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("getPopularCharacters responseCode: \(httpResponse.statusCode)")
        }
        
        if let result = try? JSONDecoder().decode(MarvelResponse<MarvelResults<MarvelCharacter>>.self, from: data) {
            return result
        }
        
        return nil
    }
    
    ///v1/public/characters/1009144/comics
    func getCharacterComics(for characterId: Int) async throws -> MarvelResponse<MarvelResults<MarvelComic>>? {
        guard let request = asGetRequest(baseURL: self.baseURL, endpoint: "/v1/public/characters/\(characterId)/comics", queryParams: [:]) else { return nil }
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("getCharacterComics responseCode: \(httpResponse.statusCode)")
        }
        
        if let result = try? JSONDecoder().decode(MarvelResponse<MarvelResults<MarvelComic>>.self, from: data) {
            return result
        }
        
        return nil
    }
    
    private func asGetRequest(baseURL: String, endpoint: String, queryParams: [String: String]) -> URLRequest? {
        let urlStr = self.baseURL + endpoint
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(self.privateKey)\(self.apiKey)".md5

        var components = URLComponents(string: urlStr)
        let defaultQueryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: self.apiKey)
        ]
        let queryItems = queryParams.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        
        components?.queryItems = defaultQueryItems + queryItems

        guard let url = components?.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        return request
    }
}
