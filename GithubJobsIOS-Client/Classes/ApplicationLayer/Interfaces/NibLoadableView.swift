//
//  NibLoadableView.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/9/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import UIKit


protocol NibLoadableView: class {
    static var nibName: String { get }
}


extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

