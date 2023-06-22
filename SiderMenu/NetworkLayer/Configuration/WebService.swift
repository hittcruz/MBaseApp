//
//  WebService.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation
import RxSwift
import UIKit
typealias LoadClosure = ()

internal enum WebServiceError: Error {
    case badStatus(Int, Data)
    case api(Int, String)
}

private struct Status: Decodable {
    let code: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case code = "status_code"
        case message = "status_message"
    }
}

extension Decodable {
    func validate(success: (() -> Void) ) {
        guard let model = self as? ResultCode, model.resultCode == nil else {
            success()
            return
        }
    }
}

final internal class WebService {
    private let session = URLSession(configuration: .default)
//    private lazy var baseURL: URL = URL(string: "https://rickandmortyapi.com/api")!
    private lazy var baseURL: URL = URL(string: "http://192.168.1.7:8000/api")!
    
    private let decoder = JSONDecoder()

    init() {
        decoder.dateDecodingStrategy = .deferredToDate
    }

    func load<T>(modelType type: T.Type, from endpoint: Endpoint, showLoader:LoadClosure? = nil, hideLoader:LoadClosure? = nil, base:URL? = nil) -> Observable<T> where T: Decodable {
        
        var baseUrl: URL
        var request: URLRequest
   
        print("WebServices baseURL ---> \(baseURL)")
        baseUrl = self.baseURL
        request = endpoint.request(with: baseUrl)
        
        let decoder = self.decoder
        let vc = UIApplication.topViewController()
        
        if showLoader == nil {
            vc?.showLoader()
        } else { showLoader }
        
            return session.rx.data(request: request)
                .map {
                    if hideLoader == nil {
                        vc?.hideLoader()
                    } else { hideLoader }
                    
//                    let json = try JSONSerialization.jsonObject(with: $0, options: []) as? [String : Any]
                    let result = try decoder.decode(T.self, from: $0)
                    return result
                }
                .catchError { error in
                    print("WebServices Error ---> \(error)")
                    if hideLoader == nil {
                        vc?.hideLoader()
                    } else { hideLoader }
                    
                    guard let webServiceError = error as? WebServiceError else {
                        throw error
                    }

                    guard case let .badStatus(_, data) = webServiceError else {
                        throw error
                    }

                    guard let status = try? decoder.decode(Status.self, from: data) else {
                        throw error
                    }

                    throw WebServiceError.api(status.code, status.message)
                    
                }
    }
}

private extension Reactive where Base: URLSession {
    func data(request: URLRequest) -> Observable<Data> {
        return Observable.create { observer in
            print("Reactive request ---> \(request)")
            let task = self.base.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Reactive Error ---> \(error)")
                    observer.onError(error)
                } else {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        fatalError("Unsupported protocol")
                    }
                    print("Reactive statusCode ---> \(httpResponse.statusCode)")
                    if 200..<300 ~= httpResponse.statusCode {
                        if let data = data {
                            observer.onNext(data)
                        }
                        observer.onCompleted()
                    } else {
                        observer.onError(WebServiceError.badStatus(httpResponse.statusCode, data ?? Data()))
                    }
                }
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
    
}
