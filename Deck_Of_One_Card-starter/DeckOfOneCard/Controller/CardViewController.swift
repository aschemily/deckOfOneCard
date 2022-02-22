//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Emily Asch on 2/22/22.
//  Copyright © 2022 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cardLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  
    
    @IBAction func drawButtonPressed(_ sender: Any) {
        CardController.fetchCard { [weak self] (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let card):
                    self?.fetchImageAndUpdateViews(for: card)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func fetchImageAndUpdateViews(for card: Card){
        CardController.fetchImage(for: card) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let image):
                    self?.cardLabel.text = "\(card.suit) and \(card.value)"
                    self?.imageView.image = image
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    

}
