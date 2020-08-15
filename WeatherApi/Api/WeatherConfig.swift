//
//  WeatherConfig.swift
//  Pods-WeatherApplication
//
//  Created by dsadaoui on 14/08/2020.
//

import Foundation

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
public struct WeatherConfig {
    
    public struct NetworkConfig {
        static let baseURL: String = "http://api.openweathermap.org/data/2.5"
        static let APIKey = "b63690dce091716867f2062f32b78ae0"
        static let session: URLSession = {
               let sessionConfig = URLSessionConfiguration.default
               sessionConfig.timeoutIntervalForRequest = 30.0
               sessionConfig.timeoutIntervalForResource = 60.0
               let session = URLSession(configuration: sessionConfig)
               return session
           }()
    }
    
    enum WeatherParameter: String {
        case city = "q"
        case lat
        case lon
        case apiKey = "appid"
        case zip
        case id
        case exclude
        case units
        case lang
    }

    enum OptionParameter: String {
        case current
        case minutely
        case hourly
        case daily
    }

    enum WeatherEndPoint: String {
        case onecall
        case current
        case forecast
    }
    enum Units: String {
        case imperial
        case metric
    }
}
