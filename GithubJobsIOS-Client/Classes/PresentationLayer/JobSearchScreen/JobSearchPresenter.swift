//
//  JobSearchPresenter.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation
import UIKit

protocol JobSearchPresenterProtocol: class {
    var dataSource: GithubJobsDataSourceProtocol! { get }
    func loadMoreData()
}

class JobSearchPresenter: NSObject, JobSearchPresenterProtocol, SetInjectable, UISearchResultsUpdating {
    private weak var view: JobSearchViewControllerProtocol!

    // MARK: JobSearchPresenterProtocol
    var dataSource: GithubJobsDataSourceProtocol!

    func onQueryChange(withNewText text: String) {
        guard dataSource.shouldReloadData(for: text) else { return }

        view.startProgressAnimation()
        dataSource.cancelLoadingData()
        dataSource.loadData(withSearchText: text) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.view.reloadData()
                case .failure(let error):
                    self.view.show(error)
                }
                self.view.stopProgressAnimation()
            }
        }
    }
}

// MARK: SetInjectable
extension JobSearchPresenter {
    typealias Dependencies = (JobSearchViewControllerProtocol?, GithubJobsDataSourceProtocol?)

    func inject(dependencies: Dependencies) {
        (view, dataSource) = dependencies
    }
}

// MARK: UISearchResultsUpdating
extension JobSearchPresenter {

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.count > 2 else { return }
        
        onQueryChange(withNewText: searchText)
    }
}

// MARK: JobSearchPresenterProtocol
extension JobSearchPresenter {
    func loadMoreData() {
        guard dataSource.shouldLoadMoreData() else { return }

        view.startProgressAnimation()
        dataSource.loadMoreData { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.view.reloadData()
                case .failure(let error):
                    self.view.show(error)
                }
                self.view.stopProgressAnimation()
            }
        }
    }
}
