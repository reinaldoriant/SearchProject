//
//  SearchSuggestionViewModel.swift
//  Search
//
//  Created by TI Digital on 28/07/21.
//

import Foundation
import Combine

protocol SearchSuggestionProtocol {
    func getRemoteSuggestion(param: String)
}

class SearchSuggestionViewModel: ObservableObject,SearchSuggestionProtocol {
    
    //MARK: - Properties For Observe
    @Published private(set) var _remoteSuggestionState: ResultState<[Document]> = .loading
    
    //MARK: - Property Others
    private(set) var _remoteSuggestionList = [Document]()
    private let _service: SearchService
    
    //MARK: - Properties Cancellable
    private var _cancellables = Set<AnyCancellable>()
    
    //MARK: - Initialize
    init(service: SearchService ) {
        self._service = service
    }
    
    func getRemoteSuggestion(param:String) {
        let cancelable = _service.getRemoteSuggestions(from: .getRemoteSuggestion(param: "Aku"))
            .sink(receiveCompletion:  { res in
                switch res {
                case .finished:
                    self._remoteSuggestionState = .success(content: self._remoteSuggestionList)
                case .failure(let error):
                    self._remoteSuggestionState = .failed(error: error)
                }
            }, receiveValue: { response in
                self._remoteSuggestionList = response.results.documents
                
            })
        self._cancellables.insert(cancelable)
    }
}
