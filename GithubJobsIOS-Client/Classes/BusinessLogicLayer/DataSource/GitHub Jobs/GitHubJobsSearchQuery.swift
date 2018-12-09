//
//  GitHubJobsSearchQuery.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/9/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation

struct GitHubJobsSearchQuery {

    var text: String

    var isValid: Bool {
        return text.count > 2
    }
}
