//
//  DailyEntity+CoreDataProperties.swift
//  WeatherApi
//
//  Created by dsadaoui on 14/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//
//

import Foundation
import CoreData


extension DailyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyEntity> {
        return NSFetchRequest<DailyEntity>(entityName: "DailyEntity")
    }

    @NSManaged public var dt: Int32
    @NSManaged public var sunrise: Int32
    @NSManaged public var sunset: Int32
    @NSManaged public var pressure: Int16
    @NSManaged public var humidity: Int16
    @NSManaged public var dewPoint: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var windDeg: Int16
    @NSManaged public var pop: Double
    @NSManaged public var rain: Double
    @NSManaged public var uvi: Double
    @NSManaged public var temp: TempEntity
    @NSManaged public var weather: NSSet
    @NSManaged public var clouds: Int16
    @NSManaged public var feelsLike: FeelsLikeEntity

}

// MARK: Generated accessors for weather
extension DailyEntity {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherEntity)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherEntity)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}
