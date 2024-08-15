//
//  DataTypes.swift
//  KHRepo
//
//  Created by Huy Hoang on 13/8/24.
//

import Combine
import Foundation

public typealias BoolPublisher = AnyPublisher<Bool, Never>
public typealias BoolSubject = PassthroughSubject<Bool, Never>
public typealias VoidPublisher = AnyPublisher<Void, Never>
public typealias VoidSubject = PassthroughSubject<Void, Never>
public typealias DataSubject<T> = PassthroughSubject<T, Never>
public typealias ValueSubject<T> = CurrentValueSubject<T, Never>
public typealias DataPublisher<T> = AnyPublisher<T, Never>
public typealias VoidCallback<T> = (T) -> Void
public typealias EmptyVoidCallback = () -> Void
public typealias EmptyCallback<T> = () -> T

public typealias CancelBag = Set<AnyCancellable>
