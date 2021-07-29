//
//  ErrorResponse.swift
//  SearchProject
//
//  Created by TI Digital on 29/07/21.
//

import Foundation

//MARK: - Enum APIError
enum ErrorResponse: Error {
    case decodingError
    case errorCode(Int)
    case unknown
    
}

//MARK: - APIError
extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
                return "Failed to decode the object from the service"
        case .errorCode(let code):
            return "\(code) - something went wrong"
        case .unknown:
            return "The error is unknown"
        }
    }
}
