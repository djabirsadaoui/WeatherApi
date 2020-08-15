//
//  TempEntity+CoreDataClass.swift
//  WeatherApi
//
//  Created by dsadaoui on 14/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TempEntity)
public class TempEntity: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case day, min, max, night, eve, morn
    }
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "TempEntity", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            day = try values.decode(Double.self, forKey: .day)
            min = try values.decode(Double.self, forKey: .min)
            max = try  values.decode(Double.self, forKey: .max)
            night  = try values.decode(Double.self, forKey: .night)
            eve = try values.decode(Double.self, forKey: .eve)
            morn = try values.decode(Double.self, forKey: .morn)
        } catch {
            print ("error")
        }
    }
}
