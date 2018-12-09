//
//  FunctionalComposition.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/7/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation

precedencegroup CompositionPrecedence {
    associativity: right
    higherThan: BitwiseShiftPrecedence
}


infix operator -=-=- : CompositionPrecedence


func -=-=-<A, B, C>(lhs: @escaping (A) -> B, rhs: @escaping (B) -> C) -> (A) -> C {
    return { rhs(lhs($0)) }
}
