//
//  WeatherDataManager.swift
//  WeatherApi
//
//  Created by dsadaoui on 12/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//

import Foundation
import CoreData

open class WeatherDataManager {
    // MARK: Vars
    public static let shared = WeatherDataManager()
    let model: String = "WeatherStore"
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return persistentContainer.viewContext
    }
    lazy var persistentContainer: NSPersistentContainer = {
        let messageKitBundle = Bundle(for: type(of: self))
        let modelURL = messageKitBundle.url(forResource: self.model, withExtension: "momd")
        guard let modelUrl = modelURL else  {
            fatalError("❌ Loading of store failed: WeatherApi does not found.")
        }
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelUrl)
        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error{
                fatalError("❌ Loading of store failed:\(err)")
            }
        }
        return container
    }()
    
    // MARK: Functions
    
    /// This function allows to save city entity in data base
    /// - Parameters:
    ///   - name: name of city
    ///   - lat: latitude
    ///   - lon: longitude
    ///   - completion: closure that returns an error if saving the city is unsuccessful. otherwise it returns the saved city object
    public func createCity(name: String, lat: Double, lon: Double, completion: @escaping(City?, WeatherError?) -> Void) {
        let city = City(context: viewContext)
        city.cityName = name
        city.lat = lat
        city.lon = lon
        do {
            try viewContext.save()
            completion(city,nil)
        } catch {
            completion(nil,.saveError)
        }
    }
    
    /// search  all the cities saved previously
    /// - Parameter completion: returns the cities found,  otherwise it returns an empty list
    public func fetchCities(completion: @escaping([City]?)-> Void) {
        let request: NSFetchRequest<City> = City.fetchRequest()
        guard let cities = try? viewContext.fetch(request) else {
            completion([])
            return
        }
        completion(cities)
    }
}
