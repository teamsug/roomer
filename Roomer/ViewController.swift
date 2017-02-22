//
//  ViewController.swift
//  Roomer
//
//  Created by Arthur Melo on 06/02/17.
//  Copyright © 2017 teamsug. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var games: [String] = ["hotpotatologo", "truthordare"]
    var nameOfGames: [String] = ["Mega Hot Potato Ultimate Edition", "The Amazing Truth or Dare 3000 Edition"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GamesCollectionViewCell
        
        cell.gameImage.image = UIImage(named: games[indexPath.row])
        cell.gameName.text = nameOfGames[indexPath.row]
        
        return cell
    }
}
