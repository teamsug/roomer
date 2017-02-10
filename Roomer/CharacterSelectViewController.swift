//
//  CharacterSelectViewController.swift
//  Roomer
//
//  Created by Arthur Melo on 07/02/17.
//  Copyright © 2017 teamsug. All rights reserved.
//

import UIKit

class PotatoCharacterSelectViewController: UIViewController {

    var numberOfPlayers = 3
    
    @IBOutlet weak var discoBallImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let gameVC = segue.destination as! PotatoGameViewController
            gameVC.numberOfPlayers = numberOfPlayers - 1
        }
    }
    
    @IBAction func nextScreenPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "segue", sender: nil)
    }
}


extension PotatoCharacterSelectViewController: UICollectionViewDataSource, UICollectionViewDelegate{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if numberOfPlayers == 9{
            return 8
        }else{
            return numberOfPlayers
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row + 1 != collectionView.numberOfItems(inSection: 0) || numberOfPlayers == 9{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "player", for: indexPath) as! PotatoCharactersCollectionViewCell
            cell.characterImage.image = UIImage(named: "eu")
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "add", for: indexPath) as! PotatoAddPlayerCollectionViewCell
            cell.addImage.image = UIImage(named: "ang")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row + 1 == collectionView.numberOfItems(inSection: 0) && numberOfPlayers < 9{
                numberOfPlayers = numberOfPlayers + 1
                collectionView.reloadData()
        }else{
            numberOfPlayers = numberOfPlayers - 1
            collectionView.reloadData()
        }
    }

}
