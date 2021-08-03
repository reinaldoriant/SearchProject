//
//  SearchNotFoundViewModel.swift
//  Search
//
//  Created by TI Digital on 28/07/21.
//

import Foundation
import Combine

protocol  SearchNotFoundProtocol {
    func getRekomendasi()
}

class SearchNotFoundViewModel: ObservableObject,SearchNotFoundProtocol {
    
    //MARK: - Properties For Observe
    @Published private(set) var _rekomendasiState: ResultState<[Article]> = .loading
    
    //MARK: - Property Others
    private(set) var _rekomendasiList = [Article]()
    private let _service: SearchServiceProtocol
    var next : Int? = 1
    //MARK: - Properties Cancellable
    private var _cancellables = Set<AnyCancellable>()
       
    //MARK: - Initialize
    init(service: SearchServiceProtocol ) {
        self._service = service
    }
    
    func getRekomendasi() {
        self._rekomendasiState = .loading
        let date = Date().getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
        let cancellable = _service
            .getRekomendasi(from: .getRekomendasi(slug: "utama", siteid: "1", timestamp: "\(date)", taxonomy: "post_tag"))
            .sink(receiveCompletion:{res in
                switch res{
                case .finished:
                    self._rekomendasiState = .success(content: self._rekomendasiList)
                case .failure(let error):
                    self._rekomendasiState = .failed(error: error)
                }
            },receiveValue: { response in
                self.next = response.result.meta.next
                self._rekomendasiList = response.result.articles
                print(response.message)
            })
        self._cancellables.insert(cancellable)
    }
}

