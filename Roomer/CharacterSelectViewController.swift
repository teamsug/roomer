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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var letsPlayButton: UIButton!
    
    var players: [UIImage] = [UIImage(named: "p1")!, UIImage(named: "p2")!, UIImage(named: "p3")!, UIImage(named: "p4")!, UIImage(named: "p5")!, UIImage(named: "p6")!, UIImage(named: "p7")!, UIImage(named: "p8")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.clipsToBounds = false
        
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
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if letsPlayButton.isFocused {
            letsPlayButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } else {
            letsPlayButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
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
        } else {
            return numberOfPlayers
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row + 1 != collectionView.numberOfItems(inSection: 0) || numberOfPlayers == 9{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "player", for: indexPath) as! PotatoCharactersCollectionViewCell
            //cell.layer.cornerRadius = cell.frame.height / 2
            //cell.characterImage.layer.cornerRadius = cell.characterImage.frame.height / 2
            cell.characterImage.image = players[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "add", for: indexPath) as! PotatoAddPlayerCollectionViewCell
            //cell.layer.cornerRadius = cell.frame.height / 2
            //cell.addImage.layer.cornerRadius = cell.addImage.frame.height / 2
            cell.addImage.image = UIImage(named: "plus")
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
