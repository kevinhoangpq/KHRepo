//
//  ViewModelExpected.swift
//  KHRepo
//
//  Created by Huy Hoang on 13/8/24.
//

import Foundation
import Combine

public protocol ViewModelExpected: AnyObject {
    associatedtype Input
    associatedtype Output
    
    var subscriptions: CancelBag { get }
    
    func transform(input: Input) -> Output
}
