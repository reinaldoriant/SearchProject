//
//  LandingSearchViewModel.swift
//  Search
//
//  Created by TI Digital on 25/07/21.
//

import Foundation
import Combine

protocol  LandingSearchViewModelProtocol {
    func getHotTopics()
    func getTerpopuler()
}

class LandingSearchViewModel: ObservableObject,LandingSearchViewModelProtocol {
    
    @Published private(set) var _hotTopicsState: ResultState<[HotList]> = .loading
    @Published private(set) var _popularState: ResultState<[SearchArticle]> = .loading
    
    private(set) var _hotList = [HotList]()
    private(set) var _terpopuler = [SearchArticle]()
    
    private let _service: SearchServiceProtocol
    private var _cancellables = Set<AnyCancellable>()
    
    
    init(service: SearchServiceProtocol ) {
        self._service = service
    }
    func getHotTopics() {
           self._hotTopicsState = .loading
           let date = Date().getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
           let cancellable = _service
               .getHotTopics(from: .getHotTopics(param: "\(date)"))
               .sink(receiveCompletion:{res in
                   switch res{
                   case .finished:
                       self._hotTopicsState = .success(content: self._hotList)
                   case .failure(let error):
                       self._hotTopicsState = .failed(error: error)
                   }
               },receiveValue: { response in
                self._hotList = response.result.hotList
            })
        self._cancellables.insert(cancellable)
    }
    
    func getTerpopuler() {
        self._popularState = .loading
        let cancellable = _service
            .getTerpopuler(from: .getTerpopuler)
            .sink(receiveCompletion:{res in
                switch res{
                case .finished:
                    self._popularState = .success(content: self._terpopuler)
                case .failure(let error):
                    self._popularState = .failed(error: error)
                }
            },receiveValue: { response in
                self._terpopuler = response.result.articles
            })
        self._cancellables.insert(cancellable)
    }
}
