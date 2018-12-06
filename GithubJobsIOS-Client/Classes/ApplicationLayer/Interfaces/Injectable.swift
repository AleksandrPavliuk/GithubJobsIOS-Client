//
//  Injectable.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation

protocol Injectable {
    associatedtype Dependencies
}

protocol InitializeInjectable: Injectable {
    init(dependencies: Dependencies)
}

protocol SetInjectable: Injectable {
    func inject(dependencies: Dependencies)
}
