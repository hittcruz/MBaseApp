//
//  EndPoint.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation

internal enum Endpoint {
    case character(serviceType: CharacterService)
    case product(serviceType: ProductService)
    case category(serviceType: CategoryService)
    case client(serviceType: ClientService)
}

protocol Requestable {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    var jsonString: String { get }
}

extension Requestable {
    var jsonString: String {
        guard let json = json(from: parameters) else { return "" }
        return json
    }
}

internal extension Endpoint {
    func request(with baseURL: URL) -> URLRequest {
        let url = baseURL.appendingPathComponent(properties.path)
        var newParameters = properties.parameters
        properties.parameters.forEach { newParameters.updateValue($1, forKey: $0) }

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!

        var request = URLRequest(url: components.url!)
        request.httpMethod = properties.method.rawValue

        if properties.method == .post {
            var headers = request.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = headers
            let jsonString = properties.jsonString
            request.httpBody = jsonString.data(using: String.Encoding.utf8)
        }

        return request
    }
}

extension Encodable {
    var json: String? {
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(self) else { return nil }
        return String(data: jsonData, encoding: String.Encoding.utf8)
    }
}

func json(from object: Any) -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
        return nil
    }
    return String(data: data, encoding: String.Encoding.utf8)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

private extension Endpoint {
    var properties: Requestable {
        switch self {
        case .character(let serviceType):
            return CharacterNetworkFactory.getService(from: serviceType)
        case .product(serviceType: let serviceType):
            return ProductNetworkFactory.getService(from: serviceType)
        case .category(serviceType: let serviceType):
            return CategoryNetworkFactory.getService(from: serviceType)
        case .client(serviceType: let serviceType):
            return ClientNetworkFactory.getService(from: serviceType)
        }
    }
}


