//
//  GitHubJobsService.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation

protocol GitHubJobsServiceProtocol {
    func findJobs(completion: @escaping (Result<GitHubJobsAPIModel, GitHubJobsError>) -> Void)
}

class GitHubJobsService: GitHubJobsServiceProtocol, InitializeInjectable {
    let networkClient: NetworkClientProtocol
    let networkRouter: GitHubJobsNetworkRouter

    // MARK: InitializeInjectable
    required init(dependencies: GitHubJobsService.Dependencies) {
        (networkClient, networkRouter) = dependencies
    }

    typealias Dependencies = (NetworkClientProtocol, GitHubJobsNetworkRouter)
}

// MARK: GitHubJobsServiceProtocol
extension GitHubJobsService {
    func findJobs(completion: @escaping (Result<GitHubJobsAPIModel, GitHubJobsError>) -> Void) {

    }
}

private extension GitHubJobsService {
    func verifyServerResponse(_ response: (data: Data?, urlResponse: HTTPURLResponse)) -> Result<Data?, GitHubJobsError> {
        if (200..<300).contains(urlResponse.statusCode) {
            return .success(response.0)
        } else {
            return .failure(.serverError(statusCode: response.urlResponse.statusCode))
        }
    }

    func parseSearchResult<T: Decodable>(_ data: Data?) -> Result<T, GitHubJobsError> {
//        guard let data = data else {
//            return .success(.empty())
//        }
    }

    // MARK: - Helper methods

    func networkErrorToResult(_ error: NetworkError) -> Result<Data?, GitHubJobsError> {
        return .failure(.networkError(error: error))
    }
}

