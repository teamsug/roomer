//
//  PotatoGameViewController.swift
//  Roomer
//
//  Created by Arthur Melo on 07/02/17.
//  Copyright © 2017 teamsug. All rights reserved.
//

import UIKit
import QuartzCore

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
    @IBOutlet weak var youareout: UIImageView!
    
    // Flag to control image changes
    var gridOnSecondChange: Bool = false
    
    // Integer to check how much pauses are needed to finish game
    var numberOfPlayers: Int!
    
    var counterOfPauses = 1
    
    // Counter to pass through movements array
    var counter = 1
    
    // Number of times the game was paused
    var timesPassed = 0
    
    // Timers to change movement and to stop game
    var timerToChangeMovement: Timer!
    var timerToPause: Timer!
    
    // Array of movements, strings of images are mounted with the movements array content
    var movements: [String] = ["pass", "hammer", "jump", "lasso", "lefthand", "righthand", "oneleg", "reverse"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        delegate.soundPlayer.stop()
            self.startTimers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CreateView {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimers() {
        let delegate = UIApplication.shared.delegate as! AppDelegate

        //CreateView {
        delay(3) {
        
            self.changeMusic(music: "02")
            
            let timeIntervalToChange = arc4random_uniform(5 - 3) + 5
            let timeIntervalToPause = arc4random_uniform(35 - 25) + 25
            
            self.timerToChangeMovement = Timer.scheduledTimer(withTimeInterval: TimeInterval(timeIntervalToChange), repeats: true) { (timer) in
                if self.counter >= self.movements.count {
                    self.counter = 0
                    self.changeMovement(to: self.movements[self.counter])
                } else {
                    //let nextMovementIndex = arc4random_uniform(self.movements.count - 1)
                    self.changeMovement(to: self.movements[self.counter])
                    self.counter = self.counter + 1
                }
            }
            
            self.timerToPause = Timer.scheduledTimer(withTimeInterval: TimeInterval(timeIntervalToPause), repeats: true) { (timer) in
                
                if self.counterOfPauses < self.numberOfPlayers - 1 {
                
                    self.timerToChangeMovement.invalidate()
        //            self.gesture.isHidden = true
        //            self.gestureNext.isHidden = true
        //            self.gestureTitle.isHidden = true
        //            self.gestureTitleNext.isHidden = true
        //            self.youareout.isHidden = false
        //            self.gestureGrid.image = UIImage(named: "youareoutGrid")
        //            self.gestureGridNext.image = UIImage(named: "youareoutGrid")
                    self.performSegue(withIdentifier: "out", sender: nil)
                    delegate.soundPlayer.stop()
                    timer.invalidate()
                    self.counterOfPauses = self.counterOfPauses + 1
                } else {
                    self.timerToChangeMovement.invalidate()
                    self.performSegue(withIdentifier: "out", sender: nil)
                    delegate.soundPlayer.stop()
                    timer.invalidate()
                    self.counterOfPauses = self.counterOfPauses + 1
                }
            }
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
            
            UIView.animate(withDuration: 0.2) {
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
            
            UIView.animate(withDuration: 0.2) {
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
    
    func CreateView(completionHandler: @escaping () -> Void){
        let customView = CustomView(frame: CGRect(x: 0.0, y: 0.0, width: 1920, height: 1080))
        self.view.addSubview(customView)
        customView.startAnimation{
            customView.removeFromSuperview()
            completionHandler()
        }
    }

    // Sending current instance of PotatoGameViewController to allow the destination VC to resume timers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "out" {
            let destinationVC = segue.destination as! PotatoPlayerOutViewController
            destinationVC.potatoGame = self
            destinationVC.timesPaused = self.counterOfPauses
            destinationVC.numberOfPlayers = self.numberOfPlayers
        }
    }
    public func delay(_ time: Int, finish: @escaping () -> Void) {
        let delay = DispatchTime.now() + .seconds(time)
        DispatchQueue.main.asyncAfter(deadline: delay, execute: finish)
    }
}

class CustomView: UIView{
    

    let label: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
            self.addCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addCustomView(){
        label.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)

        label.font = UIFont(name: "RoadRage", size: 250.0)
        label.text = "1"
        label.textColor = UIColor(colorLiteralRed: 167.0, green: 195.0, blue: 216.0, alpha: 1.0)
        self.addSubview(label)
        
        let viewAnimate = secondView(frame: CGRect(x: 0.0, y: 0.0, width: 1920, height: 1080))
        self.addSubview(viewAnimate)
        
        viewAnimate.startAnimation {
            viewAnimate.removeFromSuperview()
        }
        
    }
    
    func startAnimation(completionHandler: @escaping () -> Void) {
        let timeToStart = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            self.label.alpha = 1.0
            UIView.animate(withDuration: 1, animations: {
                self.label.alpha = 0.0
            }, completion: { (true) in
                completionHandler()
            })
        }
    }
}

class secondView: UIView{
    
    let conter: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addACowdown()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addACowdown(){
        conter.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        conter.textAlignment = NSTextAlignment.center
        conter.font = UIFont(name: "RoadRage", size: 250.0)
        conter.text = "2"
        conter.textColor = UIColor(colorLiteralRed: 167.0, green: 195.0, blue: 216.0, alpha: 1.0)
        conter.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        conter.alpha = 1.0
        self.addSubview(conter)
        
        let viewAnimate = lastView(frame: CGRect(x: 0.0, y: 0.0, width: 1920, height: 1080))
        self.addSubview(viewAnimate)
        
        viewAnimate.startAnimation {
            viewAnimate.removeFromSuperview()
        }
        
    }
    
    func startAnimation(completionHandler: @escaping () -> Void) {
        let timeToStart = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            UIView.animate(withDuration: 1, animations: {
                self.conter.alpha = 0.0
            })
        }
    }
}


class lastView: UIView{

    let backCounter: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addABackdown()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addABackdown(){
        backCounter.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        backCounter.textAlignment = NSTextAlignment.center
        backCounter.font = UIFont(name: "RoadRage", size: 250.0)
        backCounter.text = "3"
        backCounter.textColor = UIColor(colorLiteralRed: 167.0, green: 195.0, blue: 216.0, alpha: 1.0)
        backCounter.alpha = 1.0
        backCounter.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        self.addSubview(backCounter)
    }
    func startAnimation(completionHandler: @escaping () -> Void) {
        let timeToStart = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            UIView.animate(withDuration: 1, animations: {
                self.backCounter.alpha = 0.0
            })
        }
     }
}
