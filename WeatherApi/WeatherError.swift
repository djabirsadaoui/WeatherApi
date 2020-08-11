//
//  WeatherError.swift
//  WeatherApi
//
//  Created by dsadaoui on 11/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//

import Foundation

enum WeatherError: Error {
    case invalidURL(String)
    case invalidJSON(String)
    case invalidResponse
    case invalidDecoderConfiguration
    case networkError(String)
    case invalideRequest
    
    func map() -> String {
        switch self {
        case .networkError(let description):
            return description
        case .invalidJSON(let description):
            return description
        case .invalidURL(let description):
            return description
        case .invalidDecoderConfiguration:
            return "invalideDecoder"
        case .invalideRequest:
            return "invalideRequest"
        case .invalidResponse:
            return "invalidResponse"
        }
    }
}
