//
//  SearchServiceMock.swift
//  SearchProjectTests
//
//  Created by TI Digital on 02/08/21.
//

import Foundation
import Combine
import XCTest
@testable import SearchProject

struct SearchServiceMock : SearchServiceProtocol {
    func getRekomendasi(from endpoint: SearchAPI) -> AnyPublisher<RecommendationModel, ErrorResponse> {
        let jsonDecoder = JSONDecoder()
        var jsonData = Data()
        do {
            let bundlePath = Bundle.main.path(forResource: "popular", ofType: "json")
            jsonData = try String(contentsOfFile: bundlePath!).data(using: .utf8)!
        } catch {
            print("error")
        }
        return Just(jsonData)
            .decode(type: RecommendationModel.self, decoder: jsonDecoder)
            .mapError{ _ in ErrorResponse.decodingError}
            .eraseToAnyPublisher()
    }
    
    func getSearchResult(from endpoint: SearchAPI) -> AnyPublisher<SearchDetailModel, ErrorResponse>{
        let jsonDecoder = JSONDecoder()
        var jsonData = Data()
        do {
//            jsonData = try XCTestCase().getData(fromJson: "animals")
            let bundlePath = Bundle.main.path(forResource: "searchResult", ofType: "json")
            jsonData = try String(contentsOfFile: bundlePath!).data(using: .utf8)!
        } catch {
            print("error")
        }
        return Just(jsonData)
            .decode(type: SearchDetailModel.self, decoder: jsonDecoder)
            .mapError{ _ in ErrorResponse.decodingError}
            .eraseToAnyPublisher()
        
    }
    
    func getRemoteSuggestions(from endpoint: SearchAPI) -> AnyPublisher<RemoteSuggestionModel, ErrorResponse>{
        let jsonDecoder = JSONDecoder()
        var jsonData = Data()
        do {
            let bundlePath = Bundle.main.path(forResource: "remoteSuggestion", ofType: "json")
            jsonData = try String(contentsOfFile: bundlePath!).data(using: .utf8)!
        } catch {
            print("error")
        }
        return Just(jsonData)
            .decode(type: RemoteSuggestionModel.self, decoder: jsonDecoder)
            .mapError{ _ in ErrorResponse.decodingError}
            .eraseToAnyPublisher()
    }
    
    
    var returnError = false
    func getHotTopics(from endpoint: SearchAPI) -> AnyPublisher<HotTopicsModel, ErrorResponse>{
        let jsonDecoder = JSONDecoder()
        var jsonData = Data()
        do {
            let bundlePath = Bundle.main.path(forResource: "hottopic", ofType: "json")
            jsonData = try String(contentsOfFile: bundlePath!).data(using: .utf8)!
        } catch {
            print("error")
        }
        return Just(jsonData)
            .decode(type: HotTopicsModel.self, decoder: jsonDecoder)
            .mapError{ _ in ErrorResponse.decodingError}
            .eraseToAnyPublisher()
    }
    
    func getTerpopuler(from endpoint: SearchAPI) -> AnyPublisher<SearchDetailModel, ErrorResponse>{
        let jsonDecoder = JSONDecoder()
        var jsonData = Data()
        do {
//            jsonData = try XCTestCase().getData(fromJson: "animals")
            let bundlePath = Bundle.main.path(forResource: returnError ? "popularError" : "popular", ofType: "json")
            jsonData = try String(contentsOfFile: bundlePath!).data(using: .utf8)!
        } catch {
            print("error")
        }
        return Just(jsonData)
            .decode(type: SearchDetailModel.self, decoder: jsonDecoder)
            .mapError{ _ in ErrorResponse.decodingError}
            .eraseToAnyPublisher()
            
    }
    
    
}

