import Foundation

// MARK: - RecommendationModel
struct RecommendationModel: Codable {
    let status: String
    let code: Int
    let message: MessageRecommend
    let result: ResultRecommend
}

// MARK: - Message
struct MessageRecommend: Codable {
}

// MARK: - Result
struct ResultRecommend: Codable {
    let articles: [Article]
    let meta: ResultMeta
}

// MARK: - Article
struct Article: Codable {
    let title, name: String
    let permalink: String
    let thumbnails: Thumbnails
    let excerpt, publishedDate: String
    let isFreemium: Bool
    let articleByLine: ArticleByLine
    let terms: Terms
    let keyword: ArticleByLine
    let publishedDateGmt: String
    let imageCounter: Int
    let editors: [String]
    let status: Status
    let meta: ArticleMeta
    let audio: String
    let isBookmark: Bool

    enum CodingKeys: String, CodingKey {
        case title, name, permalink, thumbnails, excerpt
        case publishedDate
        case isFreemium
        case articleByLine
        case terms, keyword
        case publishedDateGmt
        case imageCounter
        case editors, status, meta, audio, isBookmark
    }
}

// MARK: - ArticleByLine
struct ArticleByLine: Codable {
    let metaKey: MetaKeyRecommend
    let metaValue: String

    enum CodingKeys: String, CodingKey {
        case metaKey
        case metaValue
    }
}

enum MetaKeyRecommend: String, Codable {
    case kompasArticleKeyword = "kompas_article_keyword"
    case kompasArticlePageNumber = "kompas_article_page_number"
    case kompasArticlePrintEditionDate = "kompas_article_print_edition_date"
    case kompasArticlePrintHeadline = "kompas_article_print_headline"
    case kompasArticleShowByline = "kompas_article_show_byline"
    case kompasPhotographerName = "kompas-photographer-name"
}
// MARK: - ArticleMeta
struct ArticleMetaRecommend: Codable {
    let cache, pin: Bool
    let print: Print
    let type: TypeEnumRecommend
    let id: Int
}

// MARK: - Print
struct Print: Codable {
    let page, edition, headline: ArticleByLine
}

enum TypeEnumRecommend: String, Codable {
    case postArticle = "post-article"
}

enum StatusRecommend: String, Codable {
    case publish = "publish"
}

// MARK: - Terms
struct TermsRecommend: Codable {
    let category, followingUsers, postTag: [CategoryRecommend]
    let postFormat: [CategoryRecommend]?

    enum CodingKeys: String, CodingKey {
        case category
        case followingUsers
        case postTag
        case postFormat
    }
}

// MARK: - Category
struct CategoryRecommend: Codable {
    let name, slug: String
}

// MARK: - Thumbnails
class ThumbnailsRecommend: Codable {
    let thumbnail, medium, mediumLarge, large: LargeRecommend?
    let postThumbnail, thumbnailMedium: LargeRecommend?
    let original: Original
    let sizes: ThumbnailsRecommend?
    let meta: ThumbnailsMeta?

    enum CodingKeys: String, CodingKey {
        case thumbnail, medium
        case mediumLarge
        case large
        case postThumbnail
        case thumbnailMedium
        case original, sizes, meta
    }

    init(thumbnail: LargeRecommend, medium: LargeRecommend, mediumLarge: LargeRecommend, large: LargeRecommend?, postThumbnail: LargeRecommend, thumbnailMedium: LargeRecommend, original: Original, sizes: ThumbnailsRecommend?, meta: ThumbnailsMeta?) {
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
    
    var availableSizesRecom : String? {
        return (medium != nil) ? medium?.permalink : (large != nil) ? large?.permalink : (mediumLarge != nil) ? mediumLarge?.permalink : original.permalink
    }
}

// MARK: - Large
struct LargeRecommend: Codable {
    let permalink: String
    let mimeType: MIMETypeRecommend
    let width, height: Int

    enum CodingKeys: String, CodingKey {
        case permalink
        case mimeType
        case width, height
    }
}

enum MIMETypeRecommend: String, Codable {
    case imageJPEG = "image/jpeg"
}

// MARK: - ThumbnailsMeta
struct ThumbnailsMetaRecommend: Codable {
    let photographerName: ArticleByLine?

    enum CodingKeys: String, CodingKey {
        case photographerName
    }
}

// MARK: - Original
struct OriginalRecommend: Codable {
    let permalink: String
    let mimeType: MIMETypeRecommend

    enum CodingKeys: String, CodingKey {
        case permalink
        case mimeType
    }
}

// MARK: - ResultMeta
struct ResultMetaRecommend: Codable {
    let site: String
    let version: Int
    let next: String
    let previous: JSONNullRecommend?
    let cache: Bool
    let total: Int
}

// MARK: - Encode/decode helpers

class JSONNullRecommend: Codable, Hashable {

    public static func == (lhs: JSONNullRecommend, rhs: JSONNullRecommend) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullRecommend.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
