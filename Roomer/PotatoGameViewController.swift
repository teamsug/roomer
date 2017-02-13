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
    @IBOutlet weak var gestureName: UILabel!
    @IBOutlet weak var gestureImage: UIImageView!
    var numberOfPlayers: Int?
    var counter = 0
    var gestures: [UIImage] = [UIImage.init(named: "appletv")!, UIImage.init(named: "appletv2")!, UIImage.init(named: "appletv3")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        changeMusic(music: "02")
        
        let timerToChangeMovement = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            if self.counter >= self.gestures.count {
                self.counter = 0
                self.gestureImage.image = self.gestures[self.counter+1]
                self.changeMusic(music: "01")
            } else {
                self.gestureImage.image = self.gestures[self.counter]
                self.counter = self.counter + 1
                self.changeMusic(music: "03")
            }
        }
        
        let timerToPause = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            let result = arc4random_uniform(5 - 1) + 1
            self.gestureName.text = String(result)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
