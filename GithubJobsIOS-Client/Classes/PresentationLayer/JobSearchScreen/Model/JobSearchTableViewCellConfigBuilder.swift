//
//  JobSearchTableViewCellConfigBuilder.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/9/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import UIKit
import Foundation

class JobSearchTableViewCellConfigBuilder {
    enum Constants {
        static let fontSize: CGFloat = 15
        static let separator = " - "
    }

    func buildJobSearchTableViewCellConfig(model: GitHubAPIJob) -> JobSearchTableViewCellConfig {
        return .init(title: model.title,
                     companyAndType: makeCompanyAndType(company: model.company, type: model.type),
                     type: model.type,
                     city: model.location,
                     time: makeRelativeTime(from: model.createdAt))
    }
}

private extension JobSearchTableViewCellConfigBuilder {
    func makeCompanyAndType(company: String, type: String) -> NSAttributedString {

        let finalString = NSMutableAttributedString()

        let attributedCompany = NSMutableAttributedString(
            string: company,
            attributes: [.font: UIFont.systemFont(ofSize: Constants.fontSize),
                         .foregroundColor: UIColor.gray]
        )
        finalString.append(attributedCompany)

        let attributedSeparator = NSMutableAttributedString(
            string: Constants.separator,
            attributes: [.font: UIFont.systemFont(ofSize: Constants.fontSize),
                         .foregroundColor: UIColor.gray]
        )
        finalString.append(attributedSeparator)

        let attributedType = NSMutableAttributedString(
            string: type,
            attributes: [.font: UIFont.boldSystemFont(ofSize: Constants.fontSize),
                         .foregroundColor: UIColor.green]
        )
        finalString.append(attributedType)

        return finalString
    }

    func makeRelativeTime(from raw: String) -> String? {
        guard let date = DateFormatter.GitHubJobsDateFormatter.date(from: raw) else {
            return nil
        }

        return date.toStringWithRelativeTime()
    }
}
