//
//  PotatoGameViewController.swift
//  Roomer
//
//  Created by Arthur Melo on 07/02/17.
//  Copyright © 2017 teamsug. All rights reserved.
//

import UIKit

class PotatoGameViewController: UIViewController {
    
    // Background outlet to setup background image
    @IBOutlet weak var backgroundPotatoGame: UIImageView!
    
    // Outlets to be changed by timers
    @IBOutlet weak var gesture: UIImageView!
    @IBOutlet weak var gestureNext: UIImageView!
    @IBOutlet weak var gestureGrid: UIImageView!
    @IBOutlet weak var gestureGridNext: UIImageView!
    @IBOutlet weak var gestureTitle: UIImageView!
    @IBOutlet weak var gestureTitleNext: UIImageView!
    
    // Flag to control image changes
    var gridOnSecondChange: Bool = false
    
    // Integer to check how much pauses are needed to finish game
    var numberOfPlayers: Int?
    
    // Counter to pass through movements array
    var counter = 0
    
    // Timers to change movement and to stop game
    var timerToChangeMovement: Timer!
    var timerToPause: Timer!
    
    // Array of movements, strings of images are mounted with the movements array content
    var movements: [String] = ["hammer", "jump", "lasso", "lefthand", "righthand", "oneleg", "reverse"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        startTimers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimers() {
        let delegate = UIApplication.shared.delegate as! AppDelegate

        changeMusic(music: "02")
        
        timerToChangeMovement = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            if self.counter >= self.movements.count {
                self.counter = 0
                self.changeMovement(to: self.movements[self.counter])
            } else {
                self.changeMovement(to: self.movements[self.counter])
                self.counter = self.counter + 1
            }
        }
        
        timerToPause = Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { (timer) in
            self.timerToChangeMovement.invalidate()
            self.performSegue(withIdentifier: "segue", sender: nil)
            delegate.soundPlayer.stop()
            timer.invalidate()
        }
    }
    
    // Called by function startTimers on every x seconds
    func changeMovement(to movement: String) {
        
        if gridOnSecondChange {
            gesture.image = UIImage(named: movement)
            gestureGrid.image = UIImage(named: "\(movement)Grid")
            gestureTitle.image = UIImage(named: "\(movement)Title")
            
            UIView.animate(withDuration: 1.5) {
                self.gestureGrid.alpha = 1.0
                self.gestureGridNext.alpha = 0.0
            }
            
            UIView.animate(withDuration: 0.5) {
                self.gesture.alpha = 1.0
                self.gestureNext.alpha = 0.0
                self.gestureTitle.alpha = 1.0
                self.gestureTitleNext.alpha = 0.0
            }
            
            gridOnSecondChange = false
        } else {
            gestureNext.image = UIImage(named: movement)
            gestureGridNext.image = UIImage(named: "\(movement)Grid")
            gestureTitleNext.image = UIImage(named: "\(movement)Title")
            
            UIView.animate(withDuration: 1.5) {
                self.gestureGrid.alpha = 0.0
                self.gestureGridNext.alpha = 1.0
            }
            
            UIView.animate(withDuration: 0.5) {
                self.gesture.alpha = 0.0
                self.gestureNext.alpha = 1.0
                self.gestureTitle.alpha = 0.0
                self.gestureTitleNext.alpha = 1.0
            }
            
            gridOnSecondChange = true
        }
    }
    
    // Called by function changeMovement to also change the music that's currently playing
    func changeMusic(music: String){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.soundPlayer.stop()
        delegate.audioToPlay = Bundle.main.path(forResource: music, ofType: "mp3")
        delegate.makeTheParty()
        delegate.soundPlayer.numberOfLoops = -1
        delegate.soundPlayer.volume = 1
        delegate.soundPlayer.play()
    }
    
    // Sending current instance of PotatoGameViewController to allow the destination VC to resume timers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let destinationVC = segue.destination as! PotatoPlayerOutViewController
            destinationVC.potatoGame = self
        }
    }
}
