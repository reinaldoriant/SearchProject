//
//  ResultState.swift
//  SearchProject
//
//  Created by TI Digital on 29/07/21.
//

import Foundation

enum ResultState<T>{
    case loading
    case success(content: T)
    case failed(error: Error)
}
