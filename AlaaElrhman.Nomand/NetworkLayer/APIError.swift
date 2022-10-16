//
//  APIError.swift
//  AlaaElrhman.Nomand
//
//  Created by AlaaElrhman on 15/10/2022.
//

import Foundation

enum APIError: Error{
    case notConnected
    case timeOut
    case notAuthorized
    case internalServerError
    case notFound
    case decodingError
    case unknown
}
extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self{
            
        case .notConnected:
            return "No Internet Connection"
        case .timeOut:
            return "No Internet Connection"
        case .notAuthorized:
            return "No Auth, please login again"
        case .internalServerError:
            return "internal server error"
        case .notFound:
            return "Not Found"
        case .decodingError:
            return "Error in mapping object"
        case .unknown:
            return "unknown"
        }
    }
}
