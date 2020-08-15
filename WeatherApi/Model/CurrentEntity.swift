//
//  CurrentEntity+CoreDataClass.swift
//  WeatherApi
//
//  Created by dsadaoui on 14/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CurrentEntity)
public class CurrentEntity: NSManagedObject, Decodable {
    public var weatherArray: [WeatherEntity] {
        return weather.toArray()
    }
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, pop, rain
    }

    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
        let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: "CurrentEntity", in: managedObjectContext)
        else {
            fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            dt = try values.decode(Int32.self, forKey: .dt)
            temp = try values.decode(Double.self, forKey: .temp)
            feelsLike = try  values.decode(Double.self, forKey: .feelsLike)
            sunset  = try values.decodeIfPresent(Int32.self, forKey: .sunset) ?? 0
            sunrise = try values.decodeIfPresent(Int32.self, forKey: .sunrise) ?? 0
            pressure = try values.decode(Int16.self, forKey: .pressure)
            humidity = try values.decode(Int16.self, forKey: .humidity)
            dewPoint = try  values.decode(Double.self, forKey: .dewPoint)
            uvi  = try values.decodeIfPresent(Double.self, forKey: .uvi) ?? 0.0
            clouds = try values.decode(Int16.self, forKey: .clouds)
            visibility = try values.decode(Int16.self, forKey: .visibility)
            windSpeed = try values.decode(Double.self, forKey: .windSpeed)
            windDeg = try  values.decode(Int16.self, forKey: .windDeg)
            weather  = NSSet(array: try values.decode([WeatherEntity].self, forKey: .weather))
            pop = try values.decodeIfPresent(Double.self, forKey: .pop) ?? 0.0
        } catch {
            print ("error")
        }
    }
}
