//
//  NetworkLibrary.swift
//  Search
//
//  Created by TI Digital on 27/07/21.
//

import Foundation

func requestBodyFrom<T>(params: T) -> Data? {
    guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
        return (nil)
    }
    return httpBody
}
