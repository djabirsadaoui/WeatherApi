//
//  WeatherData.swift
//  WeatherApi
//
//  Created by dsadaoui on 11/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//

import Foundation


// MARK: - Welcome
public struct WeatherData: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let daily: [Daily]

    enum WeatherCodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, daily
    }
}

// MARK: - Current
public struct Current: Codable {
    public let dt, sunrise, sunset: Int
    public let temp, feelsLike: Double
    public let pressure, humidity: Int
    public let dewPoint, uvi: Double
    public let clouds, visibility: Int
    public let windSpeed: Double
    public let windDeg: Int
    public let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
    }
}

// MARK: - Weather
public struct Weather: Codable {
    let id: Int
    public let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Daily
public struct Daily: Codable {
    let dt, sunrise, sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, clouds, pop, rain, uvi
    }
}

// MARK: - FeelsLike
public struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
public struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

