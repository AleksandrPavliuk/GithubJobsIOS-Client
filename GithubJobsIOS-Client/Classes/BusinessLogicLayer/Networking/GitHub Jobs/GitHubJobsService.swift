//
//  GitHubJobsService.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation

protocol GitHubJobsServiceProtocol {
    func findJobs(description: String,
                  page: UInt,
                  completion: @escaping (Result<GitHubJobsAPIModel, GitHubJobsError>) -> Void)
}

class GitHubJobsService: GitHubJobsServiceProtocol, InitializeInjectable {

    private struct Constants {
        static let apiUrl = URL(string: "https://jobs.github.com")!

        static var positionsAbsoluteURL: URL {
            return URL(string: "positions.json", relativeTo: apiUrl)!
        }
    }

    private let networkClient: NetworkClientProtocol
    private let queue: DispatchQueue

    // MARK: InitializeInjectable
    typealias Dependencies = (NetworkClientProtocol, DispatchQueue)

    required init(dependencies: Dependencies) {
        (networkClient, queue) = dependencies
    }
}

// MARK: GitHubJobsServiceProtocol
extension GitHubJobsService {

    func findJobs(description: String,
                  page: UInt,
                  completion: @escaping (Result<GitHubJobsAPIModel, GitHubJobsError>) -> Void) {

        let queryParams = ["description": description,
                           "page": String(page)]
        let url = Constants.positionsAbsoluteURL.urlWith(queryParams)!
        let request = URLRequest(url: url)
        networkClient.perform(request: request) { [weak self] (result) in
            guard let self = self else { return }
            self.queue.async {
                completion(
                    result
                        .flatMap(ifSuccess: self.verifyServerResponse, ifFailure: self.networkErrorToResult)
                        .flatMap(ifSuccess: self.parseSearchResult, ifFailure: liftError)
                )
            }
        }
    }
}

private extension GitHubJobsService {
    
    func verifyServerResponse(_ response: (data: Data?, urlResponse: HTTPURLResponse)) -> Result<Data?, GitHubJobsError> {
        if (200..<300).contains(response.urlResponse.statusCode) {
            return .success(response.0)
        } else {
            return .failure(.serverError(statusCode: response.urlResponse.statusCode))
        }
    }

    func parseSearchResult(_ data: Data?) -> Result<GitHubJobsAPIModel, GitHubJobsError> {
        guard let data = data else {
            return .success(.empty())
        }

        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(GitHubJobsAPIModel.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.parsingError(error: error))
        }
    }

    // MARK: - Helper methods

    func networkErrorToResult(_ error: NetworkError) -> Result<Data?, GitHubJobsError> {
        return .failure(.networkError(error: error))
    }
}

