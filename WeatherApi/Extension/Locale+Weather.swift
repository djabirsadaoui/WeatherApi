//
//  Locale.swift
//  Pods-WeatherApplication
//
//  Created by dsadaoui on 13/08/2020.
//

import Foundation

extension Locale {
    static var preferredLocale: Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}
