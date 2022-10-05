//
//  MovieService.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 4.10.2022.
//

import Moya

enum MovieService {

    case nowPlaying(page: Int)
    case upComing(page: Int)
    case showDetail(id: Int)
}

extension MovieService: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie")!
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var path: String {
        switch self {
        case .nowPlaying:
            return "top_rated"
        case .upComing:
            return "upcoming"
        case .showDetail(let id):
            return "\(id)"
        }
        
    }

    var method: Moya.Method {
        switch self {
        case .nowPlaying, .upComing, .showDetail:
            return .get
        }
    }

    var sampleData: Data {
        return "".data(using: .utf8)!
    }

    var task: Task {
        switch self {
        case .nowPlaying(let page), .upComing(let page):
            return .requestParameters(parameters: ["page": page, "api_key": "f84b2d8be0a804aa89fef2ac32a2bd44"], encoding: URLEncoding.queryString)
        case .showDetail:
            return .requestParameters(parameters: ["api_key": "f84b2d8be0a804aa89fef2ac32a2bd44"], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return nil
    }

}
