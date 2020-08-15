//
//  TempEntity+CoreDataProperties.swift
//  WeatherApi
//
//  Created by dsadaoui on 14/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//
//

import Foundation
import CoreData


extension TempEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TempEntity> {
        return NSFetchRequest<TempEntity>(entityName: "TempEntity")
    }

    @NSManaged public var day: Double
    @NSManaged public var min: Double
    @NSManaged public var max: Double
    @NSManaged public var eve: Double
    @NSManaged public var morn: Double
    @NSManaged public var night: Double

}
