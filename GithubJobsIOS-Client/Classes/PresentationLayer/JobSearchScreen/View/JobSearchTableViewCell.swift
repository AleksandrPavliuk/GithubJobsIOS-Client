//
//  JobSearchTableViewCell.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/6/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation
import UIKit

class JobSearchTableViewCell: UITableViewCell, Configurable, Reusable {

    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var companyAndTypeLabel: UILabel?
    @IBOutlet private weak var cityLabel: UILabel?
    @IBOutlet private weak var timeLabel: UILabel?

    // MARK: - Lifecycle

    override func prepareForReuse() {
        configure(config: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: Configurable
extension JobSearchTableViewCell {

    typealias Config = JobSearchTableViewCellConfig

    func configure(config: Config?) {
        guard let config = config else {
            titleLabel?.text = nil
            companyAndTypeLabel?.attributedText = nil
            cityLabel?.text = nil
            timeLabel?.text = nil
            return
        }

        titleLabel?.text = config.title
        companyAndTypeLabel?.attributedText = config.companyAndType
        cityLabel?.text = config.city
        timeLabel?.text = config.time
    }
}

// MARK: NibLoadableView
extension JobSearchTableViewCell {
    static var nibName: String {
        return "Main"
    }
}
