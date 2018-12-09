//
//  URL+Extensions.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/7/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation

extension URL {

    func urlWith(_ queryParams: [String: String]) -> URL? {

        let queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        return components?.url
    }

}
