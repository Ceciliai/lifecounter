//
//  ViewController.swift
//  LifeCounter
//
//  Created by Haiyi Luo on 4/21/25.
//

import UIKit

class ViewController: UIViewController {
    
    var playerLives: [Int] = [20, 20, 20, 20, 20, 20, 20, 20] // 8个玩家
    var losers: Set<Int> = []
    var gameStarted = false // 记录游戏是否开始过
    var history: [String] = []

    
    @IBOutlet var playerLifeLabels: [UILabel]! // 8个血量Label
    @IBOutlet var playerNameLabels: [UILabel]! // 8个名字Label
    @IBOutlet var customAmountFields: [UITextField]! // TextFields
    @IBOutlet var plusOneButtons: [UIButton]! // +1 Buttons
    @IBOutlet var minusOneButtons: [UIButton]! // -1 Buttons
    @IBOutlet var plusCustomButtons: [UIButton]! // +Custom Buttons
    @IBOutlet var minusCustomButtons: [UIButton]! // -Custom Buttons
    @IBOutlet var playerStackViews: [UIStackView]! // 8个玩家总StackView（拆分每一个单独的在里面）
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    
    
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var removePlayerButton: UIButton!
    
    @IBOutlet weak var loserLabel: UILabel!
    
    var currentPlayerCount = 4 // 当前玩家人数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        for (index, label) in playerNameLabels.enumerated() {
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(nameLabelTapped(_:)))
            label.addGestureRecognizer(tap)
            label.tag = index // 用 tag 记录是哪一位玩家
        }
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
        historyButton.isEnabled = true
        historyButton.isHidden = false
        gameStarted = false
    }
    
    func updateUI() {
        print("Updating UI...")

        // 更新每位玩家生命显示
        for i in 0..<currentPlayerCount {
            playerLifeLabels[i].text = "\(playerLives[i])"
            print("Player \(i+1) life updated to \(playerLives[i]).")
        }

        // 👇 遍历玩家，看是否有“新死亡”的玩家
        for i in 0..<currentPlayerCount {
            if playerLives[i] == 0 && !losers.contains(i) {
                losers.insert(i) // ✅ 加入失败者集合
                let name = playerNameLabels[i].text ?? "Player \(i + 1)"
                loserLabel.text = "\(name) LOSES!"
                loserLabel.isHidden = false
                history.append("\(name) lost the game.")
                print("🟥 \(name) loses. Label updated and history recorded.")
                break // ✅ 只显示最近失败者
            }
        }

        // 如果所有玩家都还活着，隐藏失败信息
        if (0..<currentPlayerCount).allSatisfy({ playerLives[$0] > 0 }) {
            loserLabel.text = ""
            loserLabel.isHidden = true
            print("✅ All players alive. Loser label hidden.")
        }

        // 👇 游戏结束：只剩一位玩家存活
        let aliveCount = playerLives[0..<currentPlayerCount].filter { $0 > 0 }.count
        if aliveCount == 1 {
            let alert = UIAlertController(
                title: "Game Over!",
                message: "Only one player remains.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.history.append("Game reset after Game Over alert.")
                print("🏁 Game Over confirmed. Resetting game.")
                self.resetGame(clearHistory: true) // ✅ 自动 Reset 也清除历史
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func addPlayerTapped(_ sender: UIButton) {
        print("Add Player button tapped.")
        
        if currentPlayerCount < 8 {
            playerStackViews[currentPlayerCount].isHidden = false
            playerLives[currentPlayerCount] = 20
            playerLifeLabels[currentPlayerCount].text = "20"
            playerNameLabels[currentPlayerCount].text = "Player \(currentPlayerCount + 1)"
            history.append("\(playerNameLabels[currentPlayerCount].text ?? "Player \(currentPlayerCount + 1)") joined the game.")
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
            history.append("\(playerNameLabels[currentPlayerCount].text ?? "Player \(currentPlayerCount + 1)") left the game.")
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
        let isPlus = sender.tag % 10 == 0
        
        print("Calculated playerIndex: \(playerIndex)")
        print("Is Plus: \(isPlus)")
        
        if playerLives.indices.contains(playerIndex) {
            let playerName = playerNameLabels[playerIndex].text ?? "Player \(playerIndex + 1)"
            
            if isPlus {
                playerLives[playerIndex] += 1
                history.append("\(playerName) gained 1 life.")
                print("✅ \(playerName) +1 life. New life: \(playerLives[playerIndex])")
            } else {
                playerLives[playerIndex] = max(0, playerLives[playerIndex] - 1)
                history.append("\(playerName) lost 1 life.")
                print("✅ \(playerName) -1 life. New life: \(playerLives[playerIndex])")
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
           let isPlus = sender.tag % 10 == 0

           print("Calculated playerIndex: \(playerIndex)")
           print("Is Plus: \(isPlus)")

           if playerLives.indices.contains(playerIndex) {
               if customAmountFields.indices.contains(playerIndex) {
                   let field = customAmountFields[playerIndex]
                   print("Custom Amount Field for Player \(playerIndex+1): \(field)")
                   if let text = field.text,
                      let amount = Int(text), amount > 0 {
                       let playerName = playerNameLabels[playerIndex].text ?? "Player \(playerIndex + 1)"
                       
                       if isPlus {
                           playerLives[playerIndex] += amount
                           history.append("\(playerName) gained \(amount) life.")
                           print("✅ \(playerName) +\(amount) custom life. New life: \(playerLives[playerIndex])")
                       } else {
                           playerLives[playerIndex] = max(0, playerLives[playerIndex] - amount)
                           history.append("\(playerName) lost \(amount) life.")
                           print("✅ \(playerName) -\(amount) custom life. New life: \(playerLives[playerIndex])")
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
    
    @IBAction func historyButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showHistory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistory" {
            if let historyVC = segue.destination as? HistoryViewController {
                // 把所有 history 的内容组合成一个长字符串
                let combinedHistory = history.joined(separator: "\n")
                historyVC.historyText = combinedHistory
            }
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        print("🔁 Manual reset triggered by user.")
        resetGame(clearHistory: true) // ✅ 手动 Reset 也清除历史
    }
    
    /// Resets the game to its original state.
    /// - Parameter clearHistory: If true, clears the history log as part of the reset.
    func resetGame(clearHistory: Bool = false) {
        if clearHistory {
            history.removeAll() // ✅ 清空历史记录（符合 user story 要求）
            print("🧹 History cleared as part of reset.")
        }

        for i in 0..<playerLives.count {
            playerLives[i] = 20
        }

        currentPlayerCount = 4
        for i in 0..<8 {
            playerStackViews[i].isHidden = i >= 4
            playerLifeLabels[i].text = "20"
            playerNameLabels[i].text = "Player \(i + 1)"
        }

        losers.removeAll() // ✅ 清除失败玩家集合
        loserLabel.text = ""
        loserLabel.isHidden = true
        gameStarted = false
        addPlayerButton.isEnabled = true
        removePlayerButton.isEnabled = true

        updateUI()
        print("🔄 Game reset complete.")
    }
    
    @objc func nameLabelTapped(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else { return }
        let playerIndex = label.tag
        let currentName = label.text ?? "Player \(playerIndex + 1)"

        let alert = UIAlertController(
            title: "Rename Player",
            message: "Enter a new name for \(currentName):",
            preferredStyle: .alert
        )

        alert.addTextField { textField in
            textField.placeholder = "New name"
            textField.text = currentName
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                self?.playerNameLabels[playerIndex].text = newName
                self?.history.append("\(currentName) changed name to \(newName).")
                print("✏️ Player \(playerIndex + 1) renamed to \(newName)")
            }
        }))

        present(alert, animated: true, completion: nil)
    }


}
