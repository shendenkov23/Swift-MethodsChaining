//
//  Chaining.swift
//  ExampleChaining
//
//  Created by  iDeveloper on 7/18/19.
//  Copyright © 2019 iDeveloper. All rights reserved.
//

import Foundation

public typealias ChainOperationCompletion<T> = (T) -> Void
public typealias ChainOperation<T, U> = (T, @escaping ChainOperationCompletion<U>) -> Void

public enum ChainOperationResult<T> {
  case success(T)
  case failure(Error)
}

infix operator ==>: AdditionPrecedence

func ==> <T, U, V>(f: @escaping ChainOperation<T, ChainOperationResult<U>>,
                   g: @escaping ChainOperation<U, ChainOperationResult<V>>)
  -> ChainOperation<T, ChainOperationResult<V>> {
  return { input, combineCompletion in
    f(input) { (u: ChainOperationResult<U>) in
      switch u {
      case .success(let unwrappedU): g(unwrappedU, combineCompletion)
      case .failure(let error): combineCompletion(.failure(error))
      }
    }
  }
}
