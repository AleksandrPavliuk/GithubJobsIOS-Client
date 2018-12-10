//
//  GitHubJobsAPIModel.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation

typealias GitHubJobsAPIModel = [GitHubAPIJob]

extension Array where Element == GitHubAPIJob {
    static func empty() -> GitHubJobsAPIModel {
        return [GitHubAPIJob]()
    }
}

struct GitHubAPIJob: Decodable {
    let id: String
    let type: String
    let url: String
    let createdAt: String
    let company: String
    let companyURL: String?
    let location: String
    let title: String
    let description: String
    let howToApply: String
    let companyLogo: String?

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case url
        case createdAt = "created_at"
        case company
        case companyURL = "company_url"
        case location
        case title
        case description
        case howToApply = "how_to_apply"
        case companyLogo = "company_logo"
    }
}
