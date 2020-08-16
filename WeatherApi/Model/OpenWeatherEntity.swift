//
//  OpenWeatherEntity+CoreDataClass.swift
//  WeatherApi
//
//  Created by dsadaoui on 14/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//
//

import Foundation
import CoreData


public class OpenWeatherEntity: NSManagedObject, Decodable {
    public var hourlyArray: [CurrentEntity] {
        return hourly.toArray().sorted { (current1, current2) -> Bool in
            return current1.dt < current2.dt
        }
    }
    public var dailyArray: [DailyEntity] {
        daily.toArray().sorted { (daily1, daily2) -> Bool in
            return daily1.dt < daily2.dt
        }
    }
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case current, hourly, daily
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "OpenWeatherEntity", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            lat = try values.decode(Double.self, forKey: .lat)
            lon = try values.decode(Double.self, forKey: .lon)
            timezone = try  values.decode(String.self, forKey: .timezone)
            current  = try values.decode(CurrentEntity.self, forKey: .current)
            hourly = NSSet(array: try values.decode([CurrentEntity].self, forKey: .hourly))
            daily = NSSet(array: try values.decode([DailyEntity].self, forKey: .daily))
        } catch {
            print ("error")
        }
    }
}
