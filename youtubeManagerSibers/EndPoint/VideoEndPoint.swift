//
//  File.swift
//  youtubeManagerSibers
//
//  Created by Ruslan Abbasov on 11.06.2021.
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum VideoApi {
    case search(maxResult:Int, searchWord: String)
}

extension VideoApi: EndPointType {
    
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://youtube.googleapis.com/youtube/v3/"
        case .qa: return "https://youtube.googleapis.com/youtube/v3/"
        case .staging: return "https://youtube.googleapis.com/youtube/v3/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .search:
//        return "search?part=snippet&"
        return "search"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .search(let maxResult, let searchWord):
            return .requestParameters(bodyParameters: nil,
                                       bodyEncoding: .urlEncoding,
                                       urlParameters: ["q": searchWord,
                                                        "key":NetworkManager.VideoAPIKey,
                                                        "part":NetworkManager.snippet,
                                                        "maxResults": maxResult,])
        default:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }

}
