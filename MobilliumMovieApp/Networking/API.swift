//
//  API.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 4.10.2022.
//

import Moya

final class API {
    
    static let movieProvider = MoyaProvider<MovieService>()
}
