//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by David Jedeikin on 7/9/24.
//

import XCTest
@testable import MarvelCharacters

final class MarvelCharactersTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testOnSaleDate() throws {
        let contentVM = ContentViewModel()
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "Comic", ofType: "json") else {
            fatalError("Comic.json not found")
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to String")
        }
        guard let data = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to Data")
        }
        let comic = try JSONDecoder().decode(MarvelComic.self, from: data)
        let onSaleDate = contentVM.onSaleDate(for: comic)
        
        XCTAssertEqual(onSaleDate, "Feb 16, 2023")
    }
}
