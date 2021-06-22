




import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let kind, etag, nextPageToken, regionCode: String?
    let pageInfo: PageInfo?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let kind: String?
    let etag: String?
    let id: ID?
    let snippet: Snippet?
}

// MARK: - ID
struct ID: Codable {
    let kind: String?
    let videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case videoID = "videoId"
    }
}


// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: String?
    let channelID, title, snippetDescription: String?
    let thumbnails: Thumbnails?
    let channelTitle: String?
    let liveBroadcastContent: String?
    let publishTime: String?

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, liveBroadcastContent, publishTime
    }
}


// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}
