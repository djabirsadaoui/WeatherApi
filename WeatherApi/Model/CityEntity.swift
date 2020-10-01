//
//  City.swift
//  WeatherApi
//
//  Created by dsadaoui on 12/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//

import Foundation
import CoreData

public class CityEntity: NSManagedObject, Identifiable {
    public var id = UUID()
}

extension CityEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }
 
    @NSManaged public var cityName: String?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var openWeather: OpenWeatherEntity?
}


