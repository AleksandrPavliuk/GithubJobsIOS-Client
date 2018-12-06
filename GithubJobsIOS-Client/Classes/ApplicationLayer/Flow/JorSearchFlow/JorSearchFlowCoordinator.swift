//
//  JorSearchFlowCoordinator.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation
import UIKit

class JorSearchFlowCoordinator: CoordinatorProtocol {

    let window: UIWindow

    fileprivate var navigationController: UINavigationController?
    fileprivate var homeViewController: HomeViewController?

    init(window: UIWindow) {
        self.window = window
    }
}

extension JorSearchFlowCoordinator {
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController else {
            fatalError("Error, root navigation not found")
        }

        guard let viewController = navController.viewControllers.first as? HomeViewController else {
            fatalError("Home view controller not found")
        }

//        let viewModel =
//        viewModel.coordinatorDelegate = self
//        viewController.bind(viewModel: viewModel)

        navigationController = navController
        homeViewController = viewController

        window.rootViewController = navController
    }
}
