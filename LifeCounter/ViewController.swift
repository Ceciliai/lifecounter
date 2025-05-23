//
//  ViewController.swift
//  LifeCounter
//
//  Created by Haiyi Luo on 4/21/25.
//

import UIKit

class ViewController: UIViewController {
    
    var player1Life = 20
    var player2Life = 20
    var loser: Int? = nil
 
    @IBOutlet weak var player1LifeLabel: UILabel!
    @IBOutlet weak var player2LifeLabel: UILabel!
    
    @IBOutlet weak var player1: UILabel!
    @IBOutlet weak var player2: UILabel!
    
    @IBOutlet weak var player1Add1Button: UIButton!
    @IBOutlet weak var player1Minus1Button: UIButton!
    @IBOutlet weak var player1Add5Button: UIButton!
    @IBOutlet weak var player1Minus5Button: UIButton!
    
    @IBOutlet weak var player2Add1Button: UIButton!
    @IBOutlet weak var player2Minus1Button: UIButton!
    @IBOutlet weak var player2Add5Button: UIButton!
    @IBOutlet weak var player2Minus5Button: UIButton!
    
    
    
    @IBAction func player1Add1Tapped(_ sender: UIButton) {
        player1Life += 1
        updateUI()
    }
    
    @IBAction func player1Minus1Tapped(_ sender: UIButton) {
        player1Life = max(player1Life - 1, 0)
        updateUI()
    }
    
    @IBAction func player1Add5Tapped(_ sender: UIButton) {
        player1Life += 5
        updateUI()
    }
    
    @IBAction func player1Minus5Tapped(_ sender: UIButton) {
        player1Life = max(player1Life - 5, 0)
        updateUI()
    }
    
    @IBAction func player2Add1Tapped(_ sender: UIButton) {
        player2Life += 1
        updateUI()
    }
    
    @IBAction func player2Minus1Tapped(_ sender: UIButton) {
        player2Life = max(player2Life - 1, 0)
        updateUI()
    }
    
    @IBAction func player2Add5Tapped(_ sender: UIButton) {
            player2Life += 5
            updateUI()
        }
    
    @IBAction func player2Minus5Tapped(_ sender: UIButton) {
        player2Life = max(player2Life - 5, 0)
        updateUI()
    }
    
    //@IBOutlet weak var loserLabel: UILabel!
    
    @IBOutlet weak var loserLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        player1LifeLabel.text = "\(player1Life)"
        player2LifeLabel.text = "\(player2Life)"

    
        if loser == nil {
            if player1Life <= 0 {
                loser = 0
            } else if player2Life <= 0 {
                loser = 1
            }
        }

        if let currentLoser = loser {
            if (currentLoser == 0 && player1Life <= 0) || (currentLoser == 1 && player2Life <= 0) {
                loserLabel.text = currentLoser == 0 ? "Player 1 LOSES!" : "Player 2 LOSES!"
                loserLabel.isHidden = false
            } else {
                loser = nil
                loserLabel.text = ""
                loserLabel.isHidden = true
            }
        } else {
            loserLabel.text = ""
            loserLabel.isHidden = true
        }
    }

}

