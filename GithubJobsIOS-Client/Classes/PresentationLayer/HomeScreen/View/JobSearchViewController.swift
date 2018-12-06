//
//  JobSearchViewController.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import UIKit

protocol JobSearchViewControllerProtocol: class {

}

class JobSearchViewController: UITableViewController, JobSearchViewControllerProtocol, SetInjectable {

    private struct Constants {
        static let estimatedRowHeight: CGFloat = 87.0
    }

    private var presenter: (JobSearchPresenterProtocol & UISearchResultsUpdating)!
    private var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()


        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        let tempSearchController = UISearchController(searchResultsController: nil)
        tempSearchController.searchResultsUpdater = presenter
        tempSearchController.searchBar.placeholder = "City name"
        tempSearchController.hidesNavigationBarDuringPresentation = false
        tempSearchController.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.searchController = tempSearchController
        
        searchController = tempSearchController
        
        definesPresentationContext = true
    }
}

// MARK: SetInjectable
extension JobSearchViewController {
    typealias Dependencies = (JobSearchPresenterProtocol & UISearchResultsUpdating)

    func inject(dependencies: Dependencies) {
        presenter = dependencies
    }
}

// MARK: - Actions
private extension JobSearchViewController {
    @objc private func pullToRefresh(_ sender: UIRefreshControl) {
    }
}

