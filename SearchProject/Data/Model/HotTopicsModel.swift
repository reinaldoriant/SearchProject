//
//  HotTopicsModel.swift
//  Search
//
//  Created by TI Digital on 23/07/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let hotTopicsModel = try? newJSONDecoder().decode(HotTopicsModel.self, from: jsonData)

import Foundation

// MARK: - HotTopic
struct HotTopicsModel: Codable {
//    static func == (lhs: HotTopicModel, rhs: HotTopic) -> Bool {
//        return lhs.result == rhs.result && lhs.code == rhs.code
//    }
    
    let status: String
    let code: Int
    let message: Message
    let result: Result
}

// MARK: - Message
struct Message: Codable {
}

// MARK: - Result
struct Result: Codable {
    
    let hotList: [HotList]
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case hotList = "hot_list"
        case meta
    }
}

// MARK: - HotList
struct HotList: Codable, Equatable {
    let name, tag: String
    let url: String
    let order: Int
}

// MARK: - Meta
struct Meta: Codable {
    let executionTime: Double
    let site: String
    let version: Int

    enum CodingKeys: String, CodingKey {
        case executionTime = "execution_time"
        case site, version
    }
}

extension HotList {
    static var dummyData: HotList {
        .init(name : "ppkm darurat",
              tag : "ppkm-darurat",
              url : "https://kompas.id/label/ppkm-darurat",
              order : 2)
    }
}
