//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 25/02/23.
//

import Foundation

/// object that represents a single api call
final class RMRequest {
    
    //path components
    //query parameters
    // https://rickandmortyapi.com/api/character/2
    
    /// API constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired Endpoint
   private let endPoint:RMEndpoint
    
    /// pathComponents for api, if any
   private let pathComponents:[String]
    
    /// query parameters for api, if any
   private let queryParameters:[URLQueryItem]
    
    /// Constructed url for the api request in string format
   private var urlString:String {
       var string = Constants.baseUrl
       string += "/"
       string += endPoint.rawValue
       
       if !pathComponents.isEmpty {
           pathComponents.forEach({
               string += "/\($0)"
           })
       }
       
       if !queryParameters.isEmpty {
           string += "?"
           let argumentString = queryParameters.compactMap({
               guard let value = $0.value else {return nil}
               return "\($0.name)=\(value)"
           }).joined(separator: "&")

           string += argumentString
       }
       
       return string
    }
    
    
    /// Computed and constructed API url
    public var url:URL? {
        return URL(string: urlString)
    }
    
    /// Desired httpMethod
    public let httpMethod = "GET"
    
    //MARK: Public
    /// Construct request
    /// - Parameters:
    ///   - endPoint: Target Endpoint
    ///   - pathComponents: collection of path components
    ///   - queryParameters: collection of query parameters
   public init(endPoint: RMEndpoint,
         pathComponents: [String] = [] ,
         queryParameters: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    /// Attempts to create request
    /// - Parameter url: url to parse
    convenience init?(url:URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endPointString = components[0]
                var pathComponents:[String] = []
                if components.count>1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndPoint = RMEndpoint(rawValue: endPointString) {
                    self.init(endPoint: rmEndPoint,pathComponents: pathComponents)
                    return
                }
            }
            
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty,components.count >= 2 {
                let endPointString = components[0]
                let queryItemString = components[1]
                let queryItems:[URLQueryItem] = queryItemString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                    
                })
                if let rmEndPoint = RMEndpoint(rawValue: endPointString) {
                    self.init(endPoint: rmEndPoint,queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
    
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endPoint: .character)
}
