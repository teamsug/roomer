//
//  PotatoGameViewController.swift
//  Roomer
//
//  Created by Arthur Melo on 07/02/17.
//  Copyright © 2017 teamsug. All rights reserved.
//

import UIKit

class PotatoGameViewController: UIViewController {

    @IBOutlet weak var backgroundPotatoGame: UIImageView!
    
    @IBOutlet weak var gesture: UIImageView!
    @IBOutlet weak var gestureNext: UIImageView!
    @IBOutlet weak var gestureGrid: UIImageView!
    @IBOutlet weak var gestureGridNext: UIImageView!
    
    var gridOnSecondChange: Bool = false
    
    var numberOfPlayers: Int?
    var counter = 0
    
//    var gestures: [UIImage] = [UIImage.init(named: "appletv")!, UIImage.init(named: "appletv2")!, UIImage.init(named: "appletv3")!]
    var movements: [String] = ["hammer", "jump", "lasso", "lefthand", "righthand", "oneleg", "reverse"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let timerToChangeMovement = Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { (timer) in
            if self.counter >= self.movements.count {
                self.counter = 0
                self.changeMovement(to: self.movements[self.counter])
            } else {
                self.changeMovement(to: self.movements[self.counter])
                self.counter = self.counter + 1
            }
        }
        
//        let timerToPause = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
//            let result = arc4random_uniform(5 - 1) + 1
//            //self.gestureName.text = String(result)
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeMovement(to movement: String) {
        
        if gridOnSecondChange {
            gesture.image = UIImage(named: movement)
            gestureGrid.image = UIImage(named: "\(movement)Grid")
            
            UIView.animate(withDuration: 3.0) {
                self.gesture.alpha = 1.0
                self.gestureNext.alpha = 0.0
                self.gestureGrid.alpha = 1.0
                self.gestureGridNext.alpha = 0.0
            }
            gridOnSecondChange = false
        } else {
            gestureNext.image = UIImage(named: movement)
            gestureGridNext.image = UIImage(named: "\(movement)Grid")
            
            UIView.animate(withDuration: 3.0) {
                self.gesture.alpha = 0.0
                self.gestureNext.alpha = 1.0
                self.gestureGrid.alpha = 0.0
                self.gestureGridNext.alpha = 1.0
            }
            gridOnSecondChange = true
        }
        
        
        
//        UIView.animate(withDuration: 3.0) {
//            self.gesture.alpha = 1.0
//            self.gestureGrid.alpha = 1.0
//        }
        //changeMusic(music: movement)
        
//        UIView.transition(with: self.gestureGrid, duration: 3, options: .transitionCrossDissolve, animations: {
//            self.gestureGrid.image = UIImage(named: movement)
//        }, completion: nil)
        
    }
    
    func changeMusic(music: String){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.soundPlayer.stop()
        delegate.audioToPlay = Bundle.main.path(forResource: music, ofType: "mp3")
        delegate.makeTheParty()
        delegate.soundPlayer.numberOfLoops = -1
        delegate.soundPlayer.volume = 1
        delegate.soundPlayer.play()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
