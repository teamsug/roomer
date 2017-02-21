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

    @IBOutlet weak var backgroundPotatoGame: UIImageView!
    @IBOutlet weak var gestureName: UILabel!
    @IBOutlet weak var gestureImage: UIImageView!
    
    var numberOfPlayers: Int?
    var counter = 0
    var pause = 3
    var gestures: [UIImage] = [UIImage.init(named: "appletv")!, UIImage.init(named: "appletv2")!, UIImage.init(named: "appletv3")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.soundPlayer.stop()
        
        CreateView{
        self.changeMusic(music: "02")
        
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
    
    func CreateView(completionHandler: @escaping () -> Void){
        let customView = CustomView(frame: CGRect(x: 0.0, y: 0.0, width: 1920, height: 1080))
        self.view.addSubview(customView)
        customView.startAnimation{
            customView.removeFromSuperview()
            completionHandler()
        }
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
        label.backgroundColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.text = "1"
        label.backgroundColor = UIColor.red
        self.addSubview(label)
        
        let viewAnimate = secondView(frame: CGRect(x: 0.0, y: 0.0, width: 1920, height: 1080))
        self.addSubview(viewAnimate)
        
        viewAnimate.startAnimation {
            viewAnimate.removeFromSuperview()
        }
        
    }
    
    func startAnimation(completionHandler: @escaping () -> Void) {
        let timeToStart = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
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
        conter.backgroundColor = UIColor.white
        conter.textAlignment = NSTextAlignment.center
        conter.text = "2"
        conter.alpha = 1.0
        conter.backgroundColor = UIColor.blue
        self.addSubview(conter)
        
        let viewAnimate = lastView(frame: CGRect(x: 0.0, y: 0.0, width: 1920, height: 1080))
        self.addSubview(viewAnimate)
        
        viewAnimate.startAnimation {
            viewAnimate.removeFromSuperview()
        }
        
    }
    
    func startAnimation(completionHandler: @escaping () -> Void) {
        let timeToStart = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
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
        backCounter.backgroundColor = UIColor.white
        backCounter.textAlignment = NSTextAlignment.center
        backCounter.text = "3"
        backCounter.alpha = 1.0
        backCounter.backgroundColor = UIColor.green
        self.addSubview(backCounter)
    }
    func startAnimation(completionHandler: @escaping () -> Void) {
        let timeToStart = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            UIView.animate(withDuration: 1, animations: {
                self.backCounter.alpha = 0.0
            })
        }
    }
}
