//
//  CurrentEntity+CoreDataProperties.swift
//  WeatherApi
//
//  Created by dsadaoui on 14/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//
//

import Foundation
import CoreData


extension CurrentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentEntity> {
        return NSFetchRequest<CurrentEntity>(entityName: "CurrentEntity")
    }

    @NSManaged public var clouds: Int16
    @NSManaged public var dewPoint: Double
    @NSManaged public var dt: Int32
    @NSManaged public var feelsLike: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var pop: Double
    @NSManaged public var pressure: Int16
    @NSManaged public var sunrise: Int32
    @NSManaged public var sunset: Int32
    @NSManaged public var temp: Double
    @NSManaged public var uvi: Double
    @NSManaged public var visibility: Int16
    @NSManaged public var windDeg: Int16
    @NSManaged public var windSpeed: Double
    @NSManaged public var weather: NSSet

}

// MARK: Generated accessors for weather
extension CurrentEntity {

    @objc(addWeatherObject:)
    @NSManaged  func addToWeather(_ value: WeatherEntity)

    @objc(removeWeatherObject:)
    @NSManaged  func removeFromWeather(_ value: WeatherEntity)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}
