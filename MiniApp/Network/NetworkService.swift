//
//  NetworkService.swift
//  MiniApp
//
//  Created by Danil Komarov on 05.09.2024.
//

import Foundation
import Alamofire

final class NetworkService {
    
    // MARK: - Private properties
    
    private let decoder = JSONDecoder()
    
    // MARK: - Internal Methods
    
    func getCurrentWeather(request: URLRequestConvertible?, complition: @escaping (Result<CurrentWeather?, NetworkError>) -> Void) {
        guard let request = request?.urlRequest else { return }
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if error != nil {
                complition(.failure(.urlError))
            }
            else if let data = data {
                do {
                    let result = try self?.decoder.decode(CurrentWeather.self, from: data)
                    complition(.success(result))
                } catch {
                    complition(.failure(.canNotParseData))
                }
            }
            
        } .resume()
    }
}
