//
//  SearchEndPoint.swift
//  Search
//
//  Created by TI Digital on 23/07/21.


import Foundation

//MARK: - Protocol API Builder
protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

//MARK: - Enum Search API
enum SearchAPI {
    case getHotTopics (param: String)
    case getTerpopuler
    case getRemoteSuggestion (param: String)
    case getSearchResult (param: [String: Any])
    case getRekomendasi (slug: String, siteid: String, timestamp: String, taxonomy: String)
}


//MARK: - API builder
extension SearchAPI: APIBuilder {
    //MARK: - Request API
    var urlRequest: URLRequest {
        switch self {
        
        //get data hot topics
        
        case .getHotTopics(let param):
            var getHotTopics = URLComponents(string: self.baseUrl.appendingPathComponent(self.path).absoluteString)
            getHotTopics?.queryItems =  [URLQueryItem(name: "timestamp", value: param )]
            return URLRequest(url: (getHotTopics?.url!)!)
            
        //get data terpopuler
        
        case .getTerpopuler:
            var getTerpopuler = URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
            getTerpopuler.addValue("Bearer \(TOKEN_BEARER)", forHTTPHeaderField: "Authorization")
            return getTerpopuler
            
        //get data remote suggestion
        
        case .getRemoteSuggestion(let param):
            var getRemoteSuggestion = URLComponents(string: self.baseUrl.appendingPathComponent(self.path).absoluteString)
            getRemoteSuggestion?.queryItems = [URLQueryItem(name: "query", value: param)]
            var getRemoteSuggestionFinal = URLRequest(url: (getRemoteSuggestion?.url)!)
            getRemoteSuggestionFinal.addValue("Bearer \(SEARCH_TOKEN)", forHTTPHeaderField: "Authorization")
            return getRemoteSuggestionFinal
            
        //get data search result
        
        case .getSearchResult(let param):
            var getSearchResult = URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
            getSearchResult.httpMethod = "POST"
            getSearchResult.setValue("application/json", forHTTPHeaderField: "Content-Type")
            getSearchResult.addValue("Bearer \(TOKEN_BEARER)", forHTTPHeaderField: "Authorization")
            getSearchResult.httpBody = requestBodyFrom(params: param)
            return getSearchResult
            
        //get data Rekomendasi
        case .getRekomendasi(let slug, let siteid, let timestamp, let taxonomy):
            print(slug,siteid,timestamp,taxonomy)
            
            var getRekomendasi = URLComponents(string: self.baseUrl.appendingPathComponent(self.path).absoluteString)
            let slugURL =  URLQueryItem(name: "slug", value: slug )
            let siteidURL =  URLQueryItem(name: "siteid", value: siteid )
            let timestampURL =  URLQueryItem(name: "timestamp", value: timestamp )
            let taxonomyURL =  URLQueryItem(name: "taxonomy", value: taxonomy )
            getRekomendasi?.queryItems = [slugURL,siteidURL,timestampURL,taxonomyURL]
            var getRekomendasiFinal = URLRequest(url: (getRekomendasi?.url)!)
            getRekomendasiFinal.addValue("Bearer \(TOKEN_BEARER)", forHTTPHeaderField: "Authorization")
            return getRekomendasiFinal
        }
    }
    //MARK: - Base URL
    var baseUrl: URL {
        switch self {
        case .getHotTopics,.getTerpopuler,.getSearchResult,.getRekomendasi:
            return URL(string: API_KID)!
        case .getRemoteSuggestion:
            return URL(string: API_ELASTIC)!
        }
    }
    //MARK: - Path URL
    var path: String {
        switch self{
        case .getHotTopics :
            return PATH_HOT_TOPICS
        case .getTerpopuler :
            return PATH_TERPOPULER
        case .getRemoteSuggestion:
            return PATH_REMOTE_SUGGESTIONS
        case .getSearchResult:
            return PATH_SEARCH_RESULT
        case .getRekomendasi:
            return PATH_RECOMMENDATION
        }
    }
}

