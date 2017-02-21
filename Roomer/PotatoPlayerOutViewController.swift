//
//  PotatoPlayerOutViewController.swift
//  Roomer
//
//  Created by Arthur Melo on 16/02/17.
//  Copyright © 2017 teamsug. All rights reserved.
//

import UIKit

class PotatoPlayerOutViewController: UIViewController {

    var potatoGame: PotatoGameViewController!
    
    var timesPaused = 0
    var numberOfPlayers = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(timesPaused)
        print(numberOfPlayers)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
//        for press in presses {
//            if press.type == .menu {
//                dismiss(animated: true, completion: { 
//                    self.potatoGame.startTimers()
//                })
//            }
//        }
//    }
//    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            if press.type == .menu {
                if timesPaused == numberOfPlayers - 1 {
                    performSegue(withIdentifier: "winner", sender: nil)
                } else {
                    dismiss(animated: true, completion: {
                        self.potatoGame.startTimers()
                    })
                }
            }
        }
    }
    
//    @IBAction func okPressed(_ sender: UIButton) {
//        dismiss(animated: true) {
//            self.potatoGame.startTimers()
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
