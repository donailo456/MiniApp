//
//  RouterInterface.swift
//  MiniApp
//
//  Created by Danil Komarov on 07.09.2024.
//

import Foundation
import Alamofire

protocol RouterInterface: URLRequestConvertible {
    
    var method: HTTPMethod { get }
    
    var params: [String: Any]? { get }

    var url: URL { get }
    
    var encoding: ParameterEncoding { get }
    
}

extension RouterInterface {
    
    var encoding: ParameterEncoding {
        return method.defaultEncoding
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: params)
    }
}

extension HTTPMethod {
    
    var defaultEncoding: ParameterEncoding {
        switch self {
        case .get, .delete:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
}
