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


// MARK: - Terms
struct TermsRecommend: Codable {
    let category, followingUsers, postTag: [CategoryRecommend]

    enum CodingKeys: String, CodingKey {
        case category
        case followingUsers
        case postTag
    }
}

// MARK: - Category
struct CategoryRecommend: Codable {
    let name, slug: String
}

// MARK: - Thumbnails
class ThumbnailsRecommend: Codable {
    let thumbnail, medium, mediumLarge, postThumbnail: Large?
    let thumbnailMedium: Large?
    let original: Original
    let sizes: ThumbnailsRecommend?
    let meta: ThumbnailsMeta?
    let large: Large?

    enum CodingKeys: String, CodingKey {
        case thumbnail, medium
        case mediumLarge
        case postThumbnail
        case thumbnailMedium
        case original, sizes, meta, large
    }

    init(thumbnail: Large?, medium: Large?, mediumLarge: Large, postThumbnail: Large?, thumbnailMedium: Large?, original: Original, sizes: ThumbnailsRecommend?, meta: ThumbnailsMeta?, large: Large?) {
        self.thumbnail = thumbnail
        self.medium = medium
        self.mediumLarge = mediumLarge
        self.postThumbnail = postThumbnail
        self.thumbnailMedium = thumbnailMedium
        self.original = original
        self.sizes = sizes
        self.meta = meta
        self.large = large
    }
    
    var availableSizes : String? {
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
    let photographerName: ArticleByLine

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

    public var hashValue: Int {
        return 0
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
