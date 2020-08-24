//
//  WeatherService.swift
//  WeatherApi
//
//  Created by dsadaoui on 11/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//

import Foundation




open class WeatherService {
    // MARK: Vars
    public static let shared = WeatherService()
    var dataManager: DataManager = WeatherDataManager.shared
    
    // MARK: API functions
    /// This method retrieves the weather from the server and saves it locally. in the event of no connection, it returns the local weather if present, otherwise an internet error
    /// - Parameters:
    ///   - city: city entity
    ///   - completion: closure which takes as parameter an object of type Result <OpenWeatherEntity, WeatherError>
    public func getCurrentAndForcastWeather(city: CityEntity, completion: @escaping (Result<OpenWeatherEntity, WeatherError>)-> Void) {
        if InternetManager.isConnectedToNetwork() {
            self.fetchCurrentAndForcastWeather(city: city) { (result) in
                completion(result)
            }
        } else if let openWeather = city.openWeather {
            completion(Result.success(openWeather))
        } else {
            completion(Result.failure(.networkError("Missing connection")))
        }
    }
    
    
    ///This method allows you to retrieve the weather for today and the weather forecast for the next few days
    /// - Parameters:
    ///   - city: city entity
    ///   - completion: closure which takes as parameter an object of type Result <OpenWeatherEntity, WeatherError>
    private func fetchCurrentAndForcastWeather(city: CityEntity, completion: @escaping (Result<OpenWeatherEntity, WeatherError>)-> Void) {
        let params : [WeatherConfig.WeatherParameter: String] = [.apiKey: WeatherConfig.NetworkConfig.APIKey, .lat: String(city.lat), .lon: String(city.lon), .units: WeatherConfig.Units.metric.rawValue, .exclude: WeatherConfig.OptionParameter.minutely.rawValue, .lang: Locale.preferredLocale.languageCode ?? "en" ]
        self.request(endpoint: .onecall, params: params) { [weak self](result: Result<OpenWeatherEntity, WeatherError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let openWeather):
                    city.openWeather = openWeather
                    self?.dataManager.saveContext()
                default: break
                }
                completion(result)
            }
        }
    }
    ///A private method that allows you to build a query and make a web service call
    /// - Parameters:
    ///   - endpoint: end point
    ///   - params: the parameters of the request
    ///   - completion: closure which takes as parameter an object of type Result <OpenWeatherEntity, WeatherError>
    private  func request<T: Decodable>(endpoint: WeatherConfig.WeatherEndPoint, params: [WeatherConfig.WeatherParameter: String] = [:], completion: @escaping (Result<T,WeatherError>) -> Void)  {
        guard let url = URL(string: WeatherConfig.NetworkConfig.baseURL)?.appendingPathComponent(endpoint.rawValue),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                completion(.failure(.invalidURL(endpoint.rawValue)))
                return
        }
        components.queryItems = params.compactMap { (key, value) in
            return URLQueryItem(name: key.rawValue, value: value)
        }
        guard let finalURL = components.url else {
            completion(.failure(.invalidURL(endpoint.rawValue)))
            return
        }
        let taskData = WeatherConfig.NetworkConfig.session.dataTask(with: finalURL) {[weak self](data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion( .failure(.invalidResponse))
                return
            }
            guard let data = data , response.statusCode == 200 else {
                print("Failure response from openWeather: \(response.statusCode)")
                completion(.failure(.invalideRequest))
                return
            }
            do {
                let decoder = JSONDecoder()
                guard let contextUserInfoKey = CodingUserInfoKey.context else {
                    completion(.failure(.invalidDecoderConfiguration))
                    return
                }
                decoder.userInfo[contextUserInfoKey] = self?.dataManager.viewContext
                let weather = try decoder.decode(T.self, from: data)
                
                completion(Result.success(weather))
            } catch {
                completion(.failure(.invalidDecoderConfiguration))
            }
        }
        taskData.resume()
    }
}
