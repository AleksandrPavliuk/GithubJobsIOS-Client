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

}

class JobSearchPresenter: NSObject, JobSearchPresenterProtocol, SetInjectable, UISearchResultsUpdating {
    private weak var view: JobSearchViewControllerProtocol!
}

// MARK: HomeViewPresenterProtocol
extension JobSearchPresenter {

}

// MARK: SetInjectable
extension JobSearchPresenter {
    typealias Dependencies = JobSearchViewControllerProtocol

    func inject(dependencies: Dependencies) {
        view = dependencies
    }
}

// MARK: UISearchResultsUpdating
extension JobSearchPresenter {

    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
