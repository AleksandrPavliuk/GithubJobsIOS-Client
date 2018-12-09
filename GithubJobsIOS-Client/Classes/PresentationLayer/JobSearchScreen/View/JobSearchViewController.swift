//
//  JobSearchViewController.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import UIKit

protocol JobSearchViewControllerProtocol: class {
    func startProgressAnimation()
    func stopProgressAnimation()
    func reloadData()
    func show(_ error: GitHubJobsError)
}

class JobSearchViewController: UITableViewController, JobSearchViewControllerProtocol, SetInjectable {

    private var presenter: (JobSearchPresenterProtocol & UISearchResultsUpdating)!
    private var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(headerFooterView: JobSearchTableFooterView.self)

        let tempSearchController = UISearchController(searchResultsController: nil)
        tempSearchController.searchResultsUpdater = presenter
        tempSearchController.searchBar.placeholder = "Search by title, benefits, companies, expertise"
        tempSearchController.hidesNavigationBarDuringPresentation = false
        tempSearchController.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.searchController = tempSearchController
        
        searchController = tempSearchController
    }

    private func showErrorAlert(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: SetInjectable
extension JobSearchViewController {
    typealias Dependencies = (JobSearchPresenterProtocol & UISearchResultsUpdating)

    func inject(dependencies: Dependencies) {
        presenter = dependencies
    }
}


// MARK: JobSearchViewControllerProtocol
extension JobSearchViewController {
    func startProgressAnimation() {
        guard let footerView = tableView.footerView(forSection: 0) as? JobSearchTableFooterView else { return }
        footerView.startProgressAnimation()
    }

    func stopProgressAnimation() {
        guard let footerView = tableView.footerView(forSection: 0) as? JobSearchTableFooterView else { return }
        footerView.stopProgressAnimation()
    }

    func reloadData() {
        tableView.reloadData()
    }

    func show(_ error: GitHubJobsError) {
        showErrorAlert(message: error.errorDescription)
    }
}

// MARK: - UITableViewDataSource

extension JobSearchViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JobSearchTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let config = presenter.dataSource.jobs[indexPath.row]
        cell.configure(config: config)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.jobs.count
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView() as JobSearchTableFooterView
    }

}

// MARK: UITableViewDelegate
extension JobSearchViewController {

    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
    }

    override func tableView(_ tableView: UITableView,
                            didEndDisplaying cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: UIScrollViewDelegate
extension JobSearchViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            presenter.loadMoreData()
        }
    }
}
