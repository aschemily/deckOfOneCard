//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Emily Asch on 2/22/22.
//  Copyright © 2022 Warren. All rights reserved.
//

import Foundation
import UIKit

class CardController{
   static let baseURL = URL(string:"https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void){
        //prepare url
    
        guard let baseURL = baseURL else {
            return(completion(.failure(.invalidURL)))
        }
        
        //contact server
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
            //handle errors
            if let error = error{
                print("❌error contacting server", error)
                return completion(.failure(.thrownError(error)))
            }
            //check for json data
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            //decode json into a card
            do{
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                print("👀what is toplevel object? \(topLevelObject)")
                
                if let card = topLevelObject.cards.first {
                    return completion(.success(card))
                }else{
                    return completion(.failure(.noData))
                }
            }catch{
                print("🔴unable to decode json")
            }
        }.resume()
        
    }
    
    
    static func fetchImage(for card: Card, completion: @escaping(Result<UIImage, CardError>)-> Void){
        //prepare url
        let url = card.image
        
        //contact server
        URLSession.shared.dataTask(with: url) { data, _, error in
            //handle errors from server
            if let error = error{
                return completion(.failure(.thrownError(error)))
            }
            
            //check image data
            guard let data = data else {
                return completion(.failure(.noData))
            }
           
            //initialize image
            guard let image = UIImage(data: data) else{
                return completion(.failure(.unableToDecode))
            }
            
            return completion(.success(image))
            
        }.resume()
        
    }
    
    
    
}//end of class
