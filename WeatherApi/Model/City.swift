//
//  City.swift
//  WeatherApi
//
//  Created by dsadaoui on 12/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//

import Foundation
import CoreData

public class City: NSManagedObject {
    @NSManaged open
    var cityName: String
    
    @NSManaged open
    var lat: Double
    
    @NSManaged open
    var lon: Double
    
    class func entityName () -> String {
        return String(describing: City.self)
    }
    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: self.entityName())
    }
}


