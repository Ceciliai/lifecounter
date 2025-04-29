//
//  HistoryViewController.swift
//  LifeCounter
//
//  Created by Haiyi Luo on 4/25/25.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTextView: UITextView!
    
    var historyText: String = "" // 接收传过来的内容

    override func viewDidLoad() {
        super.viewDidLoad()

        historyTextView.text = historyText // 显示历史记录
    }
}
