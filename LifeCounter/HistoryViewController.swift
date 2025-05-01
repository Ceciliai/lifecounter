//
//  HistoryViewController.swift
//  LifeCounter
//
//  Created by Haiyi Luo on 4/25/25.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTextView: UITextView!
    
    var historyText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        historyTextView.text = historyText
    }
}
