//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Emily Asch on 2/22/22.
//  Copyright © 2022 Warren. All rights reserved.
//

import Foundation

enum CardError: LocalizedError{
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String?{
        switch self{
        case .invalidURL:
            return "bad url"
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "server no data"
        case .unableToDecode:
            return "bad data"
        }
    }
}
