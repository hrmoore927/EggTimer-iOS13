//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var timer = Timer()
    var totalTime: Float = 0
    var secondsPassed: Float = 0
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0
        secondsPassed = 0
        titleLabel.text = "How do you like your eggs?"
        let hardness = sender.currentTitle!
        totalTime = Float(eggTimes[hardness]!)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            let percentageProgress = secondsPassed / totalTime
            progressBar.progress = percentageProgress
            secondsPassed += 1
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            progressBar.progress = 1
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
                player?.play()
            }
        }
    }

