//
//  JobSearchFlowCoordinator.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation
import UIKit

class JobSearchFlowCoordinator: CoordinatorProtocol {

    let window: UIWindow

    fileprivate var navigationController: UINavigationController?
    fileprivate var homeViewController: JobSearchViewController?

    init(window: UIWindow) {
        self.window = window
    }
}

extension JobSearchFlowCoordinator {
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController else {
            fatalError("Error, root navigation not found")
        }

        guard let viewController = navController.viewControllers.first as? JobSearchViewController else {
            fatalError("Home view controller not found")
        }

        let presenter = JobSearchPresenter()
        let gitHubJobsService = GitHubJobsService(dependencies: (NetworkClient(),
                                                                 DispatchQueue(label: "github.jobs.service",
                                                                               qos: .userInitiated,
                                                                               attributes: .concurrent)))
        let gitHubJobsDataSource = GithubJobsDataSource(dependencies: (gitHubJobsService,
                                                                       JobSearchTableViewCellConfigBuilder()))
        let presenterDependencies = JobSearchPresenter.Dependencies(viewController, gitHubJobsDataSource)
        presenter.inject(dependencies: presenterDependencies)

        viewController.inject(dependencies: presenter)

        navigationController = navController
        homeViewController = viewController

        window.rootViewController = navController
    }
}
