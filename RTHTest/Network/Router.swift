//
//  Router.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/2/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {

    static let host = "rth-recruitment.herokuapp.com/api"
    static let baseURLString = "https://\(Router.host)"

    static var token = "76524a53ee60602ac3528f38"

    case getPrices()

    var method: HTTPMethod {
        switch self {
        case .getPrices:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getPrices:
            return "/prices/chart_data"
        }
    }

    var contentType: String {
        switch self {
        case .getPrices:
            return "application/json"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(Router.token, forHTTPHeaderField: "X-App-Token")
        urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")

        switch self {
        case .getPrices:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: [:])
            return urlRequest
        }
    }
}
