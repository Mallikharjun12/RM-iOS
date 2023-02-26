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
   private let pathComponents:Set<String>
    
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
         pathComponents: Set<String> = [] ,
         queryParameters: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endPoint: .character)
}
