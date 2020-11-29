//
//  ViewController.swift
//  ExTimer
//
//  Created by 김종권 on 2020/11/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblInfo: UILabel!

    var startTime: Date?
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    deinit {
        timer.invalidate()
    }

    @IBAction func btnTimer(_ sender: Any) {

        guard let startTime = startTime else {
            setTimer(startTime: Date())
            return
        }
        setTimer(startTime: startTime)
    }

    private func setTimer(startTime: Date) {
        DispatchQueue.main.async { [weak self] in
            self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                let elapsedTimeSeconds = Int(Date().timeIntervalSince(startTime))
                let expireLimit = 10

                guard elapsedTimeSeconds <= expireLimit else { // 시간 초과한 경우
                    timer.invalidate()
                    self?.lblInfo.isHidden = false
                    return
                }

                let remainSeconds = expireLimit - elapsedTimeSeconds
                self?.lblTime.text = String(describing: remainSeconds.self)
            }
        }
    }
}
