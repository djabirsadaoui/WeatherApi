//
//  WeatherEnvlope.swift
//  WeatherApi
//
//  Created by dsadaoui on 11/08/2020.
//  Copyright © 2020 djabir. All rights reserved.
//

extension CodingUserInfoKey {
    static let contentIdentifier = CodingUserInfoKey(rawValue: "contentIdentifier")!
}

// SDEnvelope is the generic envelope that Weather API returns upon query
// since the actual result is keyed and of a different type every time,
// we use Decodable's userInfo to let the caller know what the expected key is

struct WeatherEnvelope<T: Decodable>: Decodable {

    let content: T

    private struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int? = nil

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        guard let ci = decoder.userInfo[CodingUserInfoKey.contentIdentifier],
                    let contentIdentifier = ci as? String,
                    let key = CodingKeys(stringValue: contentIdentifier) else {
            throw WeatherError.invalidDecoderConfiguration
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content = try container.decode(T.self, forKey: key)
    }
}
