//
//  SearchViewModel.swift
//  Search
//
//  Created by TI Digital on 23/07/21.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    //MARK: - Properties For Observe
    @Published var searchQuery = ""
    @Published var searchTyping = ""
    @Published private(set) var _searchResultState: ResultState<[SearchArticle]> = .loading
    
    //MARK: - Properties View State
    @Published var isShowLanding : Bool = true
    @Published var isShowSearchResult : Bool = false
    
    //MARK: - Properties Date
    @Published var startDate : Date = Date()
    @Published var endDate : Date = Date()
   
    //MARK: - Propertiy Others
    private(set) var _searchResultList = [SearchArticle]()
    private let _service: SearchService
    
    
    //MARK: - Properties Cancellable
    private var _cancellables = Set<AnyCancellable>()
    var searchCancellable: AnyCancellable? = nil
    
    //MARK: - Initialize
    init(service: SearchService){
        self._service = service
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { searchData in
                if searchData == ""
                {
                    print("Kosong")
                }
                else{
                    self.searchTyping = self.searchQuery
                    print(self.searchQuery)
                    print(String(self.isShowSearchResult))
                }
                
            })
    }
    
    //MARK: - View State
    var searchViewState: SearchViewState{
        if isShowLanding{
            return .searchLanding
        }
        else {
            if isShowSearchResult{
                return .searchResult
            } else {
                return .searchSuggestion
            }
        }
    }
    
    //MARK: - Get Search Result
    func getSearchResult() {
        self._searchResultState = .loading
        let body : [String: Any?] = [
            "search" : searchQuery,
            "start" : nil,
            "end" : nil,
            "cursor" : 1
        ]
        let cancellable = _service
            .getSearchResult(from: .getSearchResult(param: body as [String : Any]))
            .sink(receiveCompletion:{res in
                switch res{
                case .finished:
                    self._searchResultState = .success(content: self._searchResultList)
                case .failure(let error):
                    self._searchResultState = .failed(error: error)
                }
            },receiveValue: { response in
                self._searchResultList = response.result.articles
            })
        self._cancellables.insert(cancellable)
    }
    
    enum SearchViewState{
        case searchSuggestion
        case searchLanding
        case searchResult
    }
}
