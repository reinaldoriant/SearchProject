//
//  TerpopulerModel.swift
//  Search
//
//  Created by TI Digital on 25/07/21.
//

import Foundation

// MARK: - Popular
struct SearchDetailModel: Codable {
    
    
    let status: String
    let code: Int
    let message: Message
    let result: PopularResult
}

// MARK: - Result
struct PopularResult: Codable{
    let popular: [SearchArticle]?
    let articles: [SearchArticle]
    let meta: ResultMeta
}

// MARK: - Article
struct SearchArticle: Codable {
    
    let title, name: String
    let permalink: String
    let thumbnails: Thumbnails
    let excerpt, publishedDate: String
    let isFreemium: Bool
    let articleByLine: Keyword?
    let terms: Terms?
    let keyword: Keyword?
    let publishedDateGmt: String
    let imageCounter: Int
    let editors: [String]
    let status: Status
    let meta: ArticleMeta
    let audio: String
    let isBookmark: Bool
    let metaPopular: MetaPopular?

    enum CodingKeys: String, CodingKey {
        case title, name, permalink, thumbnails, excerpt
        case publishedDate = "published_date"
        case isFreemium = "is_freemium"
        case articleByLine = "article_by_line"
        case terms, keyword
        case publishedDateGmt = "published_date_gmt"
        case imageCounter = "image_counter"
        case editors, status, meta, audio, isBookmark
        case metaPopular = "meta_popular"
    }
}

// MARK: - Keyword
struct Keyword: Codable {
    let metaKey: MetaKey
    let metaValue: String

    enum CodingKeys: String, CodingKey {
        case metaKey = "meta_key"
        case metaValue = "meta_value"
    }
}

enum MetaKey: String, Codable {
    case kompasArticleKeyword = "kompas_article_keyword"
    case kompasArticlePageNumber = "kompas_article_page_number"
    case kompasArticlePrintEditionDate = "kompas_article_print_edition_date"
    case kompasArticlePrintHeadline = "kompas_article_print_headline"
    case kompasArticleShowByline = "kompas_article_show_byline"
    case kompasPhotographerName = "kompas-photographer-name"
    case kompasPremiumPromoKeyword = "kompas_premium_promo_keyword"
}

// MARK: - ArticleMeta
struct ArticleMeta: Codable {
    let cache, pin: Bool
    let print: PrintUnion?
    let type: TypeEnum
    let id: Int
}

enum PrintUnion: Codable {
    case anythingArray([JSONAny])
    case printClass(PrintClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONAny].self) {
            self = .anythingArray(x)
            return
        }
        if let x = try? container.decode(PrintClass.self) {
            self = .printClass(x)
            return
        }
        throw DecodingError.typeMismatch(PrintUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PrintUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anythingArray(let x):
            try container.encode(x)
        case .printClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PrintClass
struct PrintClass: Codable {
    let page, edition, headline: Keyword?
}

enum TypeEnum: String, Codable {
    case postArticle = "post-article"
    case taja = "taja"
    case promo = "promo"
}

// MARK: - MetaPopular
struct MetaPopular: Codable {
    let number: Int
}

enum Status: String, Codable {
    case publish = "publish"
}

// MARK: - Terms
struct Terms: Codable {
    let category: [Category]?
    let followingUsers, postTag: [Category]?

    enum CodingKeys: String, CodingKey {
        case category
        case followingUsers = "following_users"
        case postTag = "post_tag"
    }
}

// MARK: - Category
struct Category: Codable {
    let name, slug: String
}

// MARK: - Thumbnails
class Thumbnails: Codable {
    let thumbnail, medium, mediumLarge: Large?
    let large, postThumbnail: Large?
    let thumbnailMedium: Large?
    let original: Original
    let sizes: Thumbnails?
    let meta: ThumbnailsMeta?

    enum CodingKeys: String, CodingKey {
        case thumbnail, medium
        case mediumLarge = "medium_large"
        case large
        case postThumbnail = "post-thumbnail"
        case thumbnailMedium = "thumbnail_medium"
        case original, sizes, meta
    }

    init(thumbnail: Large, medium: Large, mediumLarge: Large, large: Large?, postThumbnail: Large?, thumbnailMedium: Large, original: Original, sizes: Thumbnails?, meta: ThumbnailsMeta?) {
        self.thumbnail = thumbnail
        self.medium = medium
        self.mediumLarge = mediumLarge
        self.large = large
        self.postThumbnail = postThumbnail
        self.thumbnailMedium = thumbnailMedium
        self.original = original
        self.sizes = sizes
        self.meta = meta
    }
    
    var availableSizes : String? {
        return (medium != nil) ? medium?.permalink : (large != nil) ? large?.permalink : (mediumLarge != nil) ? mediumLarge?.permalink : original.permalink
    }
}

// MARK: - Large
struct Large: Codable {
    let permalink: String
    let mimeType: MIMEType
    let width, height: Int

    enum CodingKeys: String, CodingKey {
        case permalink
        case mimeType = "mime-type"
        case width, height
    }
}

enum MIMEType: String, Codable {
    case imageJPEG = "image/jpeg"
    case imagePNG = "image/png"
}

// MARK: - ThumbnailsMeta
struct ThumbnailsMeta: Codable {
    let photographerName: Keyword?

    enum CodingKeys: String, CodingKey {
        case photographerName = "photographer-name"
    }
}

// MARK: - Original
struct Original: Codable {
    let permalink: String
    let mimeType: MIMEType

    enum CodingKeys: String, CodingKey {
        case permalink
        case mimeType = "mime-type"
    }
}

// MARK: - ResultMeta
struct ResultMeta: Codable {
    let executionTime: Double?
    let site: String?
    let version: Int?
    let next: Int?
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case executionTime = "execution_time"
        case site, version, next, total
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}



