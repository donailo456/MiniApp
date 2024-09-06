//
//  WeatherRouter.swift
//  MiniApp
//
//  Created by Danil Komarov on 07.09.2024.
//

import Foundation
import Alamofire

enum WeatherRouter {
    case getCurrentWeather(lat: String?, lon: String?)
}

extension WeatherRouter: RouterInterface {
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getCurrentWeather:
            return .get
        default:
            return .get
        }
    }
    
    var params: [String : Any]? {
        switch self {
        case let .getCurrentWeather(lat, lon):
            var params = [String: Any]()
            params["lat"] = lat
            params["lon"] = lon
            params["units"] = "metric"
            params["lang"] = "ru"
            params["appid"] = "0bbe7668f08533a098e6e750b6ab5abf"
            return params
        default:
            return [String : Any]()
        }
    }
    
    var url: URL {
        let relativePath: String
        switch self {
        case .getCurrentWeather:
            relativePath = "/data/2.5/weather"
        }
        
        return Constants.urlCurrentWeather.appendingPathComponent(relativePath)
    }
    
}
