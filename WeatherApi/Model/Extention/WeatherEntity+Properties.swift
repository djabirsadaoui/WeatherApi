//
//  WeatherEntity+CoreDataProperties.swift
//  WeatherApi
//
//  Created by dsadaoui on 14/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }

    @NSManaged public var icon: String
    @NSManaged public var id: Int32
    @NSManaged public var main: String
    @NSManaged public var weatherDescription: String

}
