//
//  OpenWeatherEntity+CoreDataProperties.swift
//  WeatherApi
//
//  Created by dsadaoui on 14/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//
//

import Foundation
import CoreData


extension OpenWeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OpenWeatherEntity> {
        return NSFetchRequest<OpenWeatherEntity>(entityName: "OpenWeatherEntity")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var timezone: String
    @NSManaged public var current: CurrentEntity
    @NSManaged public var hourly: NSSet
    @NSManaged public var daily: NSSet

}

// MARK: Generated accessors for hourly
extension OpenWeatherEntity {

    @objc(addHourlyObject:)
    @NSManaged public func addToHourly(_ value: CurrentEntity)

    @objc(removeHourlyObject:)
    @NSManaged public func removeFromHourly(_ value: CurrentEntity)

    @objc(addHourly:)
    @NSManaged public func addToHourly(_ values: NSSet)

    @objc(removeHourly:)
    @NSManaged public func removeFromHourly(_ values: NSSet)

}

// MARK: Generated accessors for daily
extension OpenWeatherEntity {

    @objc(addDailyObject:)
    @NSManaged public func addToDaily(_ value: DailyEntity)

    @objc(removeDailyObject:)
    @NSManaged public func removeFromDaily(_ value: DailyEntity)

    @objc(addDaily:)
    @NSManaged public func addToDaily(_ values: NSSet)

    @objc(removeDaily:)
    @NSManaged public func removeFromDaily(_ values: NSSet)

}
