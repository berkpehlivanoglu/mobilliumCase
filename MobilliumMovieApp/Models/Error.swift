//
//  Error.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 4.10.2022.
//

import Foundation

// MARK: - Error
struct Error: Codable {
    let statusCode: Int
    let statusMessage: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}
