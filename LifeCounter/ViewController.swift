//
//  ViewController.swift
//  LifeCounter
//
//  Created by Haiyi Luo on 4/21/25.
//

import UIKit

class ViewController: UIViewController {
    
    var playerLives: [Int] = [20, 20, 20, 20, 20, 20, 20, 20] // 8个玩家
    var loser: Int? = nil
    var gameStarted = false // 记录游戏是否开始过
    
    @IBOutlet var playerLifeLabels: [UILabel]! // 8个血量Label
    @IBOutlet var playerNameLabels: [UILabel]! // 8个名字Label
    @IBOutlet var customAmountFields: [UITextField]! // TextFields
    @IBOutlet var plusOneButtons: [UIButton]! // +1 Buttons
    @IBOutlet var minusOneButtons: [UIButton]! // -1 Buttons
    @IBOutlet var plusCustomButtons: [UIButton]! // +Custom Buttons
    @IBOutlet var minusCustomButtons: [UIButton]! // -Custom Buttons
    @IBOutlet var playerStackViews: [UIStackView]! // 8个玩家总StackView（拆分每一个单独的在里面）
    
    
    
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var removePlayerButton: UIButton!
    
    @IBOutlet weak var loserLabel: UILabel!
    
    var currentPlayerCount = 4 // 当前玩家人数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
    
    func setupInitialState() {
        print("Setting up initial state...")
        for i in 0..<8 {
            if i < 4 {
                playerLifeLabels[i].text = "20"
                playerNameLabels[i].text = "Player \(i + 1)"
                playerStackViews[i].isHidden = false
                print("Player \(i+1) visible at start.")
            } else {
                playerStackViews[i].isHidden = true
                print("Player \(i+1) hidden at start.")
            }
        }
        loserLabel.isHidden = true
        addPlayerButton.isEnabled = true
        removePlayerButton.isEnabled = true
        gameStarted = false
    }
    
    func updateUI() {
        print("Updating UI...")
        for i in 0..<currentPlayerCount {
            playerLifeLabels[i].text = "\(playerLives[i])"
            print("Player \(i+1) life updated to \(playerLives[i]).")
        }
        
        if loser == nil {
            for (index, life) in playerLives.enumerated() {
                if life <= 0 {
                    loser = index
                    print("Player \(index+1) has lost (life <= 0).")
                    break
                }
            }
        }
        
        if let currentLoser = loser {
            if playerLives[currentLoser] <= 0 {
                loserLabel.text = "\(playerNameLabels[currentLoser].text ?? "Player \(currentLoser + 1)") LOSES!"
                loserLabel.isHidden = false
                print("Loser label shown: \(loserLabel.text ?? "")")
            } else {
                loser = nil
                loserLabel.text = ""
                loserLabel.isHidden = true
                print("Loser label hidden (revived?).")
            }
        } else {
            loserLabel.text = ""
            loserLabel.isHidden = true
            print("No player has lost yet.")
        }
    }
    
    @IBAction func addPlayerTapped(_ sender: UIButton) {
        print("Add Player button tapped.")
        if currentPlayerCount < 8 {
            playerStackViews[currentPlayerCount].isHidden = false
            playerLifeLabels[currentPlayerCount].text = "\(playerLives[currentPlayerCount])"
            playerNameLabels[currentPlayerCount].text = "Player \(currentPlayerCount + 1)"
            print("Player \(currentPlayerCount + 1) added. Total players: \(currentPlayerCount + 1).")
            currentPlayerCount += 1
            updateUI()
        }
        if currentPlayerCount == 8 {
            addPlayerButton.isEnabled = false
            print("Add Player button disabled (max players reached).")
        }
        if currentPlayerCount > 2 {
            removePlayerButton.isEnabled = true
        }
    }
    
    @IBAction func removePlayerTapped(_ sender: UIButton) {
        print("Remove Player button tapped.")
        if currentPlayerCount > 2 {
            currentPlayerCount -= 1
            playerStackViews[currentPlayerCount].isHidden = true
            print("Player \(currentPlayerCount + 1) removed. Total players: \(currentPlayerCount).")
            updateUI()
        }
        if currentPlayerCount == 2 {
            removePlayerButton.isEnabled = false
            print("Remove Player button disabled (minimum players reached).")
        }
        if currentPlayerCount < 8 && !gameStarted {
            addPlayerButton.isEnabled = true
        } else {
            addPlayerButton.isEnabled = false
        }

    }
    
    
    @IBAction func adjustLifeTapped(_ sender: UIButton) {
        print("\n====== adjustLifeTapped called ======")
            print("Sender: \(sender)")
            print("Sender tag: \(sender.tag)")
            
            let playerIndex = (sender.tag / 10) - 1
            let isPlus = sender.tag % 10 == 0 // 修正了！！
            
            print("Calculated playerIndex: \(playerIndex)")
            print("Is Plus: \(isPlus)")
            
            if playerLives.indices.contains(playerIndex) {
                if isPlus {
                    playerLives[playerIndex] += 1
                    print("✅ Player \(playerIndex + 1) +1 life. New life: \(playerLives[playerIndex])")
                } else {
                    playerLives[playerIndex] = max(0, playerLives[playerIndex] - 1)
                    print("✅ Player \(playerIndex + 1) -1 life. New life: \(playerLives[playerIndex])")
                }
                updateUI()
                if !gameStarted {
                    gameStarted = true
                    addPlayerButton.isEnabled = false
                    print("🚀 Game started! Add Player button disabled.")
                }
            } else {
                print("❗ playerIndex \(playerIndex) out of bounds for playerLives array.")
            }
    }
    
    @IBAction func adjustCustomLifeTapped(_ sender: UIButton) {
        print("\n====== adjustCustomLifeTapped called ======")
           print("Sender: \(sender)")
           print("Sender tag: \(sender.tag)")

           let playerIndex = (sender.tag / 10) - 1
           let isPlus = sender.tag % 10 == 0 // 修正了！！

           print("Calculated playerIndex: \(playerIndex)")
           print("Is Plus: \(isPlus)")

           if playerLives.indices.contains(playerIndex) {
               if customAmountFields.indices.contains(playerIndex) {
                   let field = customAmountFields[playerIndex]
                   print("Custom Amount Field for Player \(playerIndex+1): \(field)")
                   if let text = field.text,
                      let amount = Int(text), amount > 0 {
                       if isPlus {
                           playerLives[playerIndex] += amount
                           print("✅ Player \(playerIndex + 1) +\(amount) custom life. New life: \(playerLives[playerIndex])")
                       } else {
                           playerLives[playerIndex] = max(0, playerLives[playerIndex] - amount)
                           print("✅ Player \(playerIndex + 1) -\(amount) custom life. New life: \(playerLives[playerIndex])")
                       }
                       updateUI()
                       if !gameStarted {
                           gameStarted = true
                           addPlayerButton.isEnabled = false
                           print("🚀 Game started via custom adjust! Add Player button disabled.")
                       }
                   } else {
                       print("❗ Invalid or empty custom amount entered for Player \(playerIndex+1). Field text: \(field.text ?? "nil")")
                   }
               } else {
                   print("❗ customAmountFields index \(playerIndex) out of bounds!")
               }
           } else {
               print("❗ playerIndex \(playerIndex) out of bounds for playerLives array.")
           }
       }
   }
