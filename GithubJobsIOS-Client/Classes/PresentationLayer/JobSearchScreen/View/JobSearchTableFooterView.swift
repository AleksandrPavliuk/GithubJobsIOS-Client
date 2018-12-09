//
//  JobsSearchFooterView.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/9/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import UIKit

class JobSearchTableFooterView: UITableViewHeaderFooterView, Reusable, NibLoadableView {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?

    func startProgressAnimation() {
        self.activityIndicator?.startAnimating()
    }

    func stopProgressAnimation() {
        self.activityIndicator?.stopAnimating()
    }
}
