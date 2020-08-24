//
//  WeatherDataManager.swift
//  WeatherApi
//
//  Created by dsadaoui on 12/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//

import Foundation
import CoreData

public protocol DataManager {
    static var shared: DataManager { get }
    func createCity(name: String, lat: Double, lon: Double, completion: @escaping(CityEntity?, WeatherError?) -> Void)
    func loadCities(completion: @escaping([CityEntity]?)-> Void)
    var viewContext: NSManagedObjectContext { get }
    var persistentContainer: NSPersistentContainer { get set}
    func saveContext()
}

open class WeatherDataManager: DataManager {

    // MARK: Vars
    public static let shared: DataManager = WeatherDataManager()
    let model: String = "WeatherStore"
    public var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return persistentContainer.viewContext
    }
    public lazy var persistentContainer: NSPersistentContainer = {
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
    /// This function allows to create a city entity in data base
    /// - Parameters:
    ///   - name: name of city
    ///   - lat: latitude
    ///   - lon: longitude
    ///   - completion: closure which takes as parameter two  objects : CityEntity?, WeatherError?
    public func createCity(name: String, lat: Double, lon: Double, completion: @escaping(CityEntity?, WeatherError?) -> Void) {
        let city = CityEntity(context: viewContext)
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
    public func loadCities(completion: @escaping([CityEntity]?)-> Void) {
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        guard let cities = try? viewContext.fetch(request) else {
            completion([])
            return
        }
        completion(cities)
    }
    public func saveContext() {
        guard viewContext.hasChanges  else { return }
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}

