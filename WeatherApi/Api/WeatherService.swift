//
//  WeatherService.swift
//  WeatherApi
//
//  Created by dsadaoui on 11/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//

import Foundation

enum WeatherParameter: String {
    case city = "q"
    case lat
    case lon
    case apiKey = "appid"
    case zip
    case id
    case exclude
    case units
    case lang
}

enum OptionParameter: String {
    case current
    case minutely
    case hourly
    case daily
}

enum WeatherEndPoint: String {
    case onecall
    case current
    case forecast
}
enum Units: String {
    case imperial
    case metric
}


open class WeatherService {
    public static let shared = WeatherService()
    static let session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        let session = URLSession(configuration: sessionConfig)
        return session
    }()
    static let API = "http://api.openweathermap.org/data/2.5"
    private static let APIKey = "b63690dce091716867f2062f32b78ae0"
    
    
    static func jsonDecoder(contentIdentifier: String) -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.userInfo[.contentIdentifier] = contentIdentifier
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    static func request<T: Decodable>(endpoint: WeatherEndPoint, query: [WeatherParameter: String] = [:], contentIdentifier: String, completion: @escaping (Result<T,WeatherError>) -> Void)  {
        guard let url = URL(string: API)?.appendingPathComponent(endpoint.rawValue),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                completion(.failure(.invalidURL(endpoint.rawValue)))
                return
        }
        components.queryItems = query.compactMap { (key, value) in
            return URLQueryItem(name: key.rawValue, value: value)
        }
        guard let finalURL = components.url else {
            completion(.failure(.invalidURL(endpoint.rawValue)))
            return
        }
        let taskData = session.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion( .failure(.invalidResponse))
                return
            }
            guard let data = data , response.statusCode == 200 else {
                print("Failure response from Weatherbit: \(response.statusCode)")
                completion(.failure(.invalideRequest))
                return
            }
            do {
                let decoder = self.jsonDecoder(contentIdentifier: contentIdentifier)
                let envelope = try decoder.decode(WeatherEnvelope<T>.self, from: data)
                completion(.success(envelope.content))
            } catch {
                completion(.failure(.invalidDecoderConfiguration))
            }
        }
        taskData.resume()
    }
    
    public func getCurrentWeather(city: String, completion: @escaping (Result<[Weather], WeatherError>) -> Void) {
        // parameters
        let query : [WeatherParameter: String] = [.apiKey: WeatherService.APIKey, .city: city]
       
        WeatherService.request(endpoint: .current, query: query, contentIdentifier: "weather") { (result: Result<[Weather], WeatherError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    public func getCurrentAndForcastWeather(lat: String, lon: String, completion: @escaping (Result<Current, WeatherError>)-> Void) {
        let query : [WeatherParameter: String] = [.apiKey: WeatherService.APIKey, .lat: lat, .lon: lon, .units: Units.metric.rawValue, .exclude:"\(OptionParameter.minutely),\(OptionParameter.hourly)", .lang: Locale.preferredLocale.languageCode ?? "en" ]
        WeatherService.request(endpoint: .onecall, query: query, contentIdentifier: "current") { (result: Result<Current, WeatherError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    private func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}