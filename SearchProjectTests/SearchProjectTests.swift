//
//  SearchProjectTests.swift
//  SearchProjectTests
//
//  Created by TI Digital on 29/07/21.
//

import XCTest
@testable import SearchProject

class SearchProjectTests: XCTestCase {

    private var viewModelLanding : LandingSearchViewModel!
    private var viewModelSearch : SearchViewModel!
    private var viewModelNotFound : SearchNotFoundViewModel!
    private var mockService: SearchServiceMock!
    
    override func setUpWithError() throws {
        mockService = SearchServiceMock()
        viewModelLanding = .init(service: mockService)
        viewModelSearch = .init(service: mockService)
        viewModelNotFound = .init(service: mockService)
    }
    
    override func tearDownWithError() throws {
        mockService = nil
        viewModelLanding = nil
    }
    
    override func tearDown() {
        viewModelSearch.isShowLanding = true
        viewModelSearch.isShowSearchResult = false
    }
    //MARK: - Landing Search ViewModel
    func testgetTerpopuler(){
        viewModelLanding.getTerpopuler()
        XCTAssertNotNil(viewModelLanding._popularState)
    }
    
    func testgetHotTopics(){
        viewModelLanding.getHotTopics()
        XCTAssertNotNil(viewModelLanding._hotTopicsState)
    }
   
    func testIsiKonten(){
        viewModelLanding.getTerpopuler()
        XCTAssertEqual(viewModelLanding._terpopuler[0].name, "kritik-keras-bung-hatta-untuk-pemerintahan-soekarno")
    }
    
    func testgetHottopic() {
        viewModelLanding.getHotTopics()
        XCTAssertEqual(viewModelLanding._hotList[0].tag, "olimpiade-tokyo-2020")
    }
    
    //MARK: - Search ViewModel
    func testRemoteSuggestion() {
        viewModelSearch.getRemoteSuggestion(param: "makan")
        XCTAssertEqual(viewModelSearch._remoteSuggestionList[1].suggestion, "makan orang")
    }
    
    func testSearchResult() {
        viewModelSearch.getSearchResult()
        XCTAssertEqual(viewModelSearch._searchResultList[0].name, "jokowi-amin-melompatlah")
    }
    
    func testSearchLoadmore() {
        viewModelSearch.infiniteScroll()
        XCTAssertEqual(viewModelSearch._searchResultList[0].name, "jokowi-amin-melompatlah")
    }

    //MARK: - Search Not Found ViewModel
    
//    func testNotFound() {
//        viewModelNotFound.getRekomendasi()
//        XCTAssertEqual(viewModelNotFound._rekomendasiList[0].name, "kritik-keras-bung-hatta-untuk-pemerintahan-soekarno")
//    }
    
    //MARK: -
    func testModels() throws {
        var jsonData = Data()
        do {
            let bundlePath = Bundle.main.path(forResource: "popular", ofType: "json")
            jsonData = try String(contentsOfFile: bundlePath!).data(using: .utf8)!
        } catch {
            print("error")
        }
        let response = try JSONDecoder().decode(SearchDetailModel.self, from: jsonData)
        
        XCTAssertEqual(response.result.articles.count, 10)
        XCTAssertEqual(response.code, 200)
        
    }
}
