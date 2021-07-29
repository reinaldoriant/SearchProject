//
//  BodySearchResult.swift
//  Search
//
//  Created by TI Digital on 27/07/21.
//

import Foundation

struct BodySearchResult: Codable {
    let end, search, start: String
    let cursor: Int
}
