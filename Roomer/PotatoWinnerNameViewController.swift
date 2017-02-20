//
//  PotatoWinnerNameViewController.swift
//  Roomer
//
//  Created by Arthur Melo on 20/02/17.
//  Copyright © 2017 teamsug. All rights reserved.
//

import UIKit

class PotatoWinnerNameViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        if !(textField.text?.isEmpty)! {
            performSegue(withIdentifier: "winner", sender: nil)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "winner" {
            let destinationVC = segue.destination as! PotatoWinnerViewController
            destinationVC.winnerName = textField.text!
        }
    }
}
