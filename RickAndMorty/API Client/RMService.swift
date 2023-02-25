//
//  RMService.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 25/02/23.
//

import Foundation

/// Primary API service object to get Rick&Morty data
final class RMService {
    /// shared singleton instance
    static let shared = RMService()
    
    /// privatized constructor
    private init() {}
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: request instance
    ///   - completion: callback with data or error
    ///   - type: The type of object we expect to get back
    public func execute<T:Codable>(_ request:RMRequest,
                                   expecting type:T.Type,
                                   completion:@escaping (Result<T,Error>)->Void
    ) {
        
    }
}
