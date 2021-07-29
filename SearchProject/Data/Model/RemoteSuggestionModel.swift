//
//  AutocompleteModel.swift
//  Search
//
//  Created by TI Digital on 27/07/21.
//

import Foundation

// MARK: - RemoteSuggestion
struct RemoteSuggestionModel: Codable {
    let results: ResultsSuggestion
    let meta: MetaSuggestion
}

// MARK: - Meta
struct MetaSuggestion: Codable {
    let requestID: String

    enum CodingKeys: String, CodingKey {
        case requestID = "request_id"
    }
}

// MARK: - Results
struct ResultsSuggestion: Codable{
    let documents: [Document]
}

// MARK: - Document
struct Document: Codable, Equatable {
    let suggestion: String
}
