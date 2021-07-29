//
//  SearchService.swift
//  Search
//
//  Created by TI Digital on 23/07/21.
//

import Foundation
import Combine

//MARK: - Protocol
protocol SearchProtocol {
    func getHotTopics(from endpoint: SearchAPI) -> AnyPublisher<HotTopicsModel, ErrorResponse>
    func getTerpopuler(from endpoint: SearchAPI) -> AnyPublisher<SearchDetailModel, ErrorResponse>
    func getRemoteSuggestions(from endpoint: SearchAPI) -> AnyPublisher<RemoteSuggestionModel, ErrorResponse>
}

//MARK: - Service
struct SearchService: SearchProtocol {
    
    //MARK: - Get Hot Topics
    func getHotTopics(from endpoint: SearchAPI) -> AnyPublisher<HotTopicsModel, ErrorResponse>{
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{_ in ErrorResponse.unknown}
            .flatMap{ data, response -> AnyPublisher<HotTopicsModel,ErrorResponse> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: ErrorResponse.unknown).eraseToAnyPublisher()
                }
                if(200...299).contains(response.statusCode){
                    return Just(data)
                        .decode(type: HotTopicsModel.self , decoder: JSONDecoder())
                        .mapError{ error in
                            return ErrorResponse.decodingError
                        }
                        .eraseToAnyPublisher()
                }
                else{
                    return Fail(error: ErrorResponse.errorCode(response.statusCode)).eraseToAnyPublisher()
                }

            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - Get Terpopuler
    func getTerpopuler(from endpoint: SearchAPI) -> AnyPublisher<SearchDetailModel, ErrorResponse>{
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{_ in ErrorResponse.unknown}
            .flatMap{ data, response -> AnyPublisher<SearchDetailModel,ErrorResponse> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: ErrorResponse.unknown).eraseToAnyPublisher()
                }
                if(200...299).contains(response.statusCode){
                    let jsonDcoder = JSONDecoder()
                    return Just(data)
                        .decode(type: SearchDetailModel.self , decoder: jsonDcoder)
                        .mapError{_ in
                            ErrorResponse.decodingError
                        }
                        .eraseToAnyPublisher()
                }
                else{
                    return Fail(error: ErrorResponse.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - Post Remote Suggestion
    func getRemoteSuggestions(from endpoint: SearchAPI) -> AnyPublisher<RemoteSuggestionModel, ErrorResponse>{
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{_ in ErrorResponse.unknown}
            .flatMap{ data, response -> AnyPublisher<RemoteSuggestionModel,ErrorResponse> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: ErrorResponse.unknown).eraseToAnyPublisher()
                }
                if(200...299).contains(response.statusCode){
                    let jsonDcoder = JSONDecoder()
                    return Just(data)
                        .decode(type: RemoteSuggestionModel.self , decoder: jsonDcoder)
                        .mapError{_ in
                            ErrorResponse.decodingError
                        }
                        .eraseToAnyPublisher()
                }
                else{
                    return Fail(error: ErrorResponse.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - Get Search Result
    func getSearchResult(from endpoint: SearchAPI) -> AnyPublisher<SearchDetailModel, ErrorResponse>{
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{_ in ErrorResponse.unknown}
            .flatMap{ data, response -> AnyPublisher<SearchDetailModel,ErrorResponse> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: ErrorResponse.unknown).eraseToAnyPublisher()
                }
                if(200...299).contains(response.statusCode){
                    return Just(data)
                        .decode(type: SearchDetailModel.self , decoder: JSONDecoder())
                        .mapError{ error in
                            return ErrorResponse.decodingError
                        }
                        .eraseToAnyPublisher()
                }
                else{
                    return Fail(error: ErrorResponse.errorCode(response.statusCode)).eraseToAnyPublisher()
                }

            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - Get Search Result
    func getRekomendasi(from endpoint: SearchAPI) -> AnyPublisher<RecommendationModel, ErrorResponse>{
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{_ in ErrorResponse.unknown}
            .flatMap{ data, response -> AnyPublisher<RecommendationModel,ErrorResponse> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: ErrorResponse.unknown).eraseToAnyPublisher()
                }
                if(200...299).contains(response.statusCode){
                    return Just(data)
                        .decode(type: RecommendationModel.self , decoder: JSONDecoder())
                        .mapError{ error in
                            return ErrorResponse.decodingError
                        }
                        .eraseToAnyPublisher()
                }
                else{
                    return Fail(error: ErrorResponse.errorCode(response.statusCode)).eraseToAnyPublisher()
                }

            }
            .eraseToAnyPublisher()
    }
}
