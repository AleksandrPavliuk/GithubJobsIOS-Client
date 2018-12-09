//
//  Configurable.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/9/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation


protocol Configurable {
    associatedtype Config

    func configure(config: Config?)
}
