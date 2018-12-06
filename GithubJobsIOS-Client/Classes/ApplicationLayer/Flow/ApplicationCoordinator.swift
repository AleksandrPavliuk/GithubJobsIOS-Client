//
//  ApplicationCoordinator.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation
import UIKit

protocol ApplicationCoordinatorProtocol: CoordinatorProtocol {

}

class ApplicationCoordinator: ApplicationCoordinatorProtocol {

    let window: UIWindow

    private var jorSearchFlowCoordinator: CoordinatorProtocol?

    init(window: UIWindow) {
        self.window = window
    }
}


// MARK: ApplicationCoordinatorProtocol
extension ApplicationCoordinator {
    func start() {
        jorSearchFlowCoordinator = JorSearchFlowCoordinator(window: window)
        jorSearchFlowCoordinator?.start()
    }
}
