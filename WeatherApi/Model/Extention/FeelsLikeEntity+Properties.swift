//
//  FeelsLikeEntity+CoreDataProperties.swift
//  WeatherApi
//
//  Created by dsadaoui on 14/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//
//

import Foundation
import CoreData


extension FeelsLikeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeelsLikeEntity> {
        return NSFetchRequest<FeelsLikeEntity>(entityName: "FeelsLikeEntity")
    }

    @NSManaged public var day: Double
    @NSManaged public var night: Double
    @NSManaged public var eve: Double
    @NSManaged public var morn: Double

}
