//
//  GitHubJobsError.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation


enum GitHubJobsError: LocalizedError {
    case networkError(error: NetworkError)
    case serverError(statusCode: Int)
    case parsingError(error: Error)

    var errorDescription: String? {
        switch self {
        case .networkError(let networkError):
            return "Network error: \(networkError.localizedDescription)"
        case .serverError(let statusCode):
            return "Server error \(statusCode)"
        case .parsingError(let parsingError):
            return "Parsing error: \(parsingError.localizedDescription)"
        }
    }
}
