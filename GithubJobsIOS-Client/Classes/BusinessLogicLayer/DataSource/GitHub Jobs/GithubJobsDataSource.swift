//
//  GithubJobsRepository.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/9/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation

protocol GithubJobsDataSourceProtocol {
    typealias GithubJobsDataSourceResultHandler = (Result<Void, GitHubJobsError>) -> Void
    var jobs: [JobSearchTableViewCellConfig] { get }

    func loadData(withSearchText text: String, completion: @escaping GithubJobsDataSourceResultHandler)
    func loadMoreData(completion: @escaping GithubJobsDataSourceResultHandler)
    func shouldReloadData(for searchText: String) -> Bool
    func shouldLoadMoreData() -> Bool
    func cancelLoadingData()
}

class GithubJobsDataSource: GithubJobsDataSourceProtocol, InitializeInjectable {

    private enum LoadingType {
        case fullReload
        case loadMore
    }

    private let gitHubJobsService: GitHubJobsServiceProtocol
    private let jobCellConfigBuilder: JobSearchTableViewCellConfigBuilder
    private var isLoading = false
    private var nextPageNumber: UInt = 0
    private var latestSearchQuery: GitHubJobsSearchQuery?

    // MARK: InitializeInjectable
    typealias Dependencies = (GitHubJobsServiceProtocol, JobSearchTableViewCellConfigBuilder)

    required init(dependencies: Dependencies) {
        (gitHubJobsService, jobCellConfigBuilder) = dependencies
    }

    var jobs = [JobSearchTableViewCellConfig]()

    // MARK: - Private methods
    private func loadDataChunk(loadingType: LoadingType,
                               withSearchQuery query: GitHubJobsSearchQuery,
                               completion: @escaping GithubJobsDataSourceResultHandler) {
        guard !isLoading else { return }
        guard query.isValid else { return }

        let requestPage = nextPageNumber

        isLoading = true

        gitHubJobsService.findJobs(description: query.text, page: requestPage) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                let jobs = response.map(self.jobCellConfigBuilder.buildJobSearchTableViewCellConfig)
                self.updateModels(withModels: jobs, shouldAppend: (loadingType == .loadMore))
                self.nextPageNumber = jobs.count > 0 ? requestPage + 1 : requestPage

                self.isLoading = false

                completion(.success(()))

            case .failure(let error):
                self.isLoading = false
                completion(.failure(error))
            }
        }
    }

    private func updateModels(withModels newModels: [JobSearchTableViewCellConfig], shouldAppend: Bool) {
        jobs = shouldAppend ? (jobs + newModels) : newModels
    }

}

// MARK: GithubJobsDataSourceProtocol
extension GithubJobsDataSource {

    func loadData(withSearchText text: String, completion: @escaping GithubJobsDataSourceResultHandler) {
        let query = GitHubJobsSearchQuery(text: text)
        latestSearchQuery = query
        loadDataChunk(loadingType: .fullReload, withSearchQuery: query, completion: completion)
    }

    func loadMoreData(completion: @escaping GithubJobsDataSourceResultHandler) {
        guard let query = latestSearchQuery else { return }
        loadDataChunk(loadingType: .loadMore, withSearchQuery: query, completion: completion)
    }

    func shouldReloadData(for searchText: String) -> Bool {
        return latestSearchQuery?.text != searchText
    }

    func shouldLoadMoreData() -> Bool {
        return latestSearchQuery != nil
    }

    func cancelLoadingData() {
        latestSearchQuery = nil
        isLoading = false
        nextPageNumber = 0
    }
}
