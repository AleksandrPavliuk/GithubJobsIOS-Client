//
//  Result.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation

enum Result<T, TError> {
    case success(T)
    case failure(TError)
}
