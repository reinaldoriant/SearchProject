//
//  LandingSearch.swift
//  Search
//
//  Created by TI Digital on 22/07/21.
//

import SwiftUI
import BottomSheet



struct SearchView: View {
    //MARK: - Properties
    @StateObject private var _viewModel = SearchViewModel(service: SearchService())
    @State private var bottomSheetPosition: SearchBottomSheet = .hidden
    @State var expand = false
    // MARK: - Body
    var body: some View {
        VStack {
            searchBar
            switch _viewModel.searchViewState{
            case .searchLanding :
                landingSearch
            case .searchSuggestion:
                searchSuggestion
            case .searchResult:
                searchResultView
            }
        }
        
        .bottomSheet(
            bottomSheetPosition: self.$bottomSheetPosition,
            options: [.backgroundBlur(.systemMaterialDark),
                      .tapToDissmiss, .swipeToDismiss, .noBottomPosition, .background(AnyView(Color.white)),
                      .noBottomPosition
            ],
            content: {searchBottomSheet} )
    }
    
    //MARK: - Search Bar
    var searchBar: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                // Back Button
                Button(action: {
                    withAnimation{
                        if(_viewModel.isLandingState){
                            exit(0)
                        }
                        else{
                            _viewModel.isShowLanding = true
                            _viewModel.searchQuery = ""
                            _viewModel.isShowSearchResult = false
                        }
                        
                    }
                }, label: {
                    Image(systemName: "arrow.left")
                        .padding(.leading,16)
                        .foregroundColor(Color(UIColor(named: "ColorBlueKompas")!))
                })
                // Search Field
                SearchFieldViewItem(viewModel: _viewModel)
                    .disabled(_viewModel.isShowLanding || _viewModel.isShowSearchResult)
                    .onTapGesture {
                        withAnimation {
                            _viewModel.isShowSearchResult = false
                            _viewModel.isShowLanding = false
                        }
                    }
                // Show Filter
                if _viewModel.isShowFilter{
                    withAnimation{
                        searchFilter
                    }
                }
            }
        }
        
    }
    
    //MARK: - Landing Search
    var landingSearch : some View{
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading, spacing: 24 ){
                if(!_viewModel.localSuggestionDatas.isEmpty) {
                    withAnimation(.easeIn){
                        LocalSuggestionView(viewModel: _viewModel,onItemTap: onTapSuggestion)
                    }
                }
                LandingSearchView()
            }
        }
        .onAppear{
            _viewModel.getLocalSuggestion()
            _viewModel.isLandingState = true
        }
        .ignoresSafeArea(.all, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
        
    }
    
    //MARK: - Search Result
    var searchResultView: some View {
        Group {
            switch _viewModel._searchResultState {
            case .loading:
                SpinnerBar()
                Spacer()
            case .success(let content):
                if(content.isEmpty) {
                    SearchNotFoundView()
                }else {
                    withAnimation(.easeIn){
                        SearchFoundView(viewModel: _viewModel)
                    }
                }
            case .failed(let error):
                Text("Error gini Cong ???? \(error.localizedDescription)")
                Spacer()
            }
        }
        .onAppear{
            _viewModel.isLandingState = false
            
        }
        
    }
    //MARK: - Search Filter
    var searchFilter: some View {
        Button(action: {
            bottomSheetPosition = .medium
        }, label: {
            FilterViewItem()
        })
    }
    
    //MARK: - Suggestion
    var searchSuggestion: some View {
        SuggestionView(viewModel: _viewModel,onItemTap: onTapSuggestion)
            .padding(.leading,60)
            .padding(.trailing,30)
            .onAppear{
                _viewModel.isLandingState = false
            }
    }
    
    //MARK: - Search Bottom Sheet
    var searchBottomSheet: some View {
        VStack(alignment: .leading) {
            //Filter Pencarian & Reset
            HStack(alignment: .top) {
                Text("Filter Pencarian")
                    .hindSemiBold18Black()
                Spacer()
                resetFilterButton
                
            }
            .padding(.bottom, 16)
            .padding(.top, 19)
            .padding(.horizontal,16)
            //Tanggal Terbit & Rentang waktu
            HStack(content: {
                    Text("Tanggal Terbit")
                        .hindSemiBold16Black()
                    Spacer()
                    Toggle(isOn: $_viewModel.isShowRange)
                    {
                        Text("Rentang waktu")
                            .hindRegular16Black()
                    }
                    .toggleStyle(CheckboxStyle())
                    .onChange(of: _viewModel.isShowRange, perform: { value in
                        _viewModel.isShowRange.toggle()
                    })}
            ).padding(.bottom, 13)
            .padding(.horizontal,16)
            //Start date & end date
            HStack(alignment: .center) {
                DatePicker("", selection: $_viewModel.startDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .labelsHidden()
                
                if _viewModel.isShowRange {
                    Spacer()
                    Text("-")
                    Spacer()
                    DatePicker("", selection: $_viewModel.endDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .labelsHidden()
                }
            }.padding(.bottom,37)
            .padding(.horizontal,16)
            //Button Apply
            
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea(.all, edges: .bottom)
                    .shadow(radius: 1)
                buttonApplyBottom
                    .padding(.horizontal,16)
                    .padding(.top,10)
            }
            
        }
        
    }
    
    //MARK: - Button Apply Bottom Sheet
    var buttonApplyBottom : some View{
        HStack(alignment:.center) {
            Button(action: {
                _viewModel.isUseFilter = true
                _viewModel.next = 1
                _viewModel.getSearchResult()
                _viewModel.isApplyFilter = true
                bottomSheetPosition = .hidden
            }, label: {
                Text("Terapkan")
                    .foregroundColor(.white)
                    .hindSemiBold16Black()
            })
            .buttonStyle(BoxButton())
        }
    }
    //MARK: - Button Reset BottomSheet
    var resetFilterButton : some View {
        Button(action: {
            _viewModel.isUseFilter = false
            _viewModel.getSearchResult()
            bottomSheetPosition = .hidden
        }, label: {
            Text("Reset")
                .hindSemiBold16Blue()
        })
    }
    
    //MARK: - On Tap Suggestion
    func onTapSuggestion(string : String){
        withAnimation {
            _viewModel.onTapSuggestion(text: string)
        }
    }
}

//The custom BottomSheetPosition enum.
enum SearchBottomSheet: CGFloat, CaseIterable {
    case medium = 0.35, hidden = 0
}


