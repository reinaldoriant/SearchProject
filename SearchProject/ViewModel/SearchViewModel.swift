//
//  SearchViewModel.swift
//  Search
//
//  Created by TI Digital on 23/07/21.
//

import Foundation
import Combine
import CoreData

class SearchViewModel: ObservableObject {
    
    
    
    //MARK: - Properties For Observe
    @Published var searchQuery = ""
    @Published private(set) var _searchResultState: ResultState<[SearchArticle]> = .loading
    @Published private(set) var _remoteSuggestionState: ResultState<[Document]> = .loading
    @Published var localSuggestionDatas: [TaskViewModel] = []
    
    //MARK: - Properties View State
    @Published var isShowLanding : Bool = true
    @Published var isShowSearchResult : Bool = false
    @Published var isLandingState: Bool = true
    
    var isShowClearText : Bool {
        return !searchQuery.isEmpty && !isShowSearchResult && !isShowLanding
    }
    
    //MARK: - Properties Filter
    @Published var startDate : Date = Date()
    @Published var endDate : Date = Date()
    @Published var isUseFilter = false
    @Published var isShowRange = false
    var isApplyFilter = false
    var isShowFilter : Bool {
        return isShowSearchResult && !_searchResultList.isEmpty
    }
    
    //MARK: - Propertiy Others
    private(set) var _searchResultList = [SearchArticle]()
    private(set) var _remoteSuggestionList = [Document]()
    private let _service: SearchServiceProtocol
    
    //MARK: - Properties Cancellable
    private var _cancellables = Set<AnyCancellable>()
    var searchCancellable: AnyCancellable? = nil
    
    //MARK: - Properties Loadmore
    var next : Int? = 1
    @Published var loadMoreDown = false
    
    
    //MARK: - Initialize
    init(service: SearchServiceProtocol){
        self._service = service
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { searchData in
                if (searchData == "")
                {
                    self._remoteSuggestionState = .success(content: [Document]())
                }
                else{
                    if(searchData.count >= 3){
                        self.getRemoteSuggestion(param: searchData)
                        print(self.searchQuery)
                    }
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
    
    var showLocalSuggestions : [TaskViewModel] {
        let data = localSuggestionDatas.count >= 5 ? Array(localSuggestionDatas.prefix(5)) : localSuggestionDatas
        return data
    }
    
    //MARK: - Get Search Result
    func getSearchResult() {
        self._searchResultState = .loading
        let body : [String: Any?] = [
            "search" : searchQuery,
            "start" : isUseFilter ? "\(startDate.getFormattedDate(format: "yyyy-MM-dd"))" : nil,
            "end" : isUseFilter ? "\(endDate.getFormattedDate(format: "yyyy-MM-dd"))" : nil,
            "cursor" : 1
        ]
        print(startDate)
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
                self.next = response.result.meta.next
                self.loadMoreDown = false
            })
        self._cancellables.insert(cancellable)
    }
    
    //MARK: - InfiniteScroll
    func infiniteScroll(){
        let body : [String: Any?] = [
            "search" : searchQuery,
            "start" : isUseFilter ? "\(startDate)" : nil,
            "end" : isUseFilter ? "\(endDate)" : nil,
            "cursor" : next! as Int
        ]
        let cancelable = _service.getSearchResult(from: .getSearchResult(param: body as [String : Any]))
            .sink(receiveCompletion: { res in
                switch res {
                case .finished:
                    self._searchResultState = .success(content: self._searchResultList)
                case .failure(let error):
                    self._searchResultState = .failed(error: error)
                }
            }, receiveValue: { response in
                for i in 0..<response.result.articles.count {
                    self._searchResultList.append(response.result.articles[i])
                }
                self.next = response.result.meta.next
                self.loadMoreDown = false
            })
        self._cancellables.insert(cancelable)
    }
    
    //MARK: - Get Remote Suggestion
    func getRemoteSuggestion(param:String) {
        let cancelable = _service.getRemoteSuggestions(from: .getRemoteSuggestion(param: param))
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
    
    //MARK: - Save Local Suggestion
    func saveLocalSuggestion(){
        let localSuggestion = LocalSuggestion(context: CoreDataManager.shared.viewContext)
        localSuggestion.name = searchQuery
        CoreDataManager.shared.save()
        
    }
    //MARK: - Fetch data Local Suggestion
    
    func getLocalSuggestion(){
        localSuggestionDatas = CoreDataManager.shared.getAll().map(TaskViewModel.init).reversed()
    }
    
    //MARK: - Delete data Local Suggestion
    func deleteLocalSuggestion(_ name: LocalSuggestion) {
        CoreDataManager.shared.delete(name: name)
        getLocalSuggestion()
    }
    
    //MARK: - Delete data Local Suggestion
    func deleteAllLocalSuggestion() {
        CoreDataManager.shared.deleteAll()
        getLocalSuggestion()
    }
    
    func onTapSuggestion(text: String){
        searchQuery = text
        isShowSearchResult = true
        getSearchResult()
        isShowLanding = false
    }
    
    //MARK: - Enum
    enum SearchViewState{
        case searchSuggestion
        case searchLanding
        case searchResult
    }
    
   
}

struct TaskViewModel {
    let localSuggestion: LocalSuggestion
    var id : NSManagedObjectID{
        return localSuggestion.objectID
    }
    var name: String {
        return localSuggestion.name ?? ""
    }
}
