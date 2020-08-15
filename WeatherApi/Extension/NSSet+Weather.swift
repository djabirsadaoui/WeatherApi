//
//  NSSet+Weather.swift
//  Pods-WeatherApplication
//
//  Created by dsadaoui on 14/08/2020.
//

import Foundation
extension NSSet {
  func toArray<T>() -> [T] {
    let array = self.map({ $0 as! T})
    return array
  }
}
