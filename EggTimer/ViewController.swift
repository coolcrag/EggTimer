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
    
    var eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var SecondsRemaining = 60
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var barProgress: UIProgressView!
    var currentPoseIndex = 0
    var indexProgressBar = 0
    var poseDuration = 20
    var player: AVAudioPlayer?

    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        timer.invalidate()
        barProgress.progress = 0.0
        topLabel.text = hardness
        poseDuration = eggTimes[hardness]!
        SecondsRemaining = eggTimes[hardness]!
        
    
     
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

    }
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")

        do {
            player = try AVAudioPlayer(contentsOf: url!)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }

    func setProgressBar()
        {
            if indexProgressBar == poseDuration
            {

                // reset the progress counter
                indexProgressBar = 0
            }

            // update the display
            // use poseDuration - 1 so that you display 20 steps of the the progress bar, from 0...19
        barProgress.progress = Float(indexProgressBar) / Float(poseDuration - 1)

            // increment the counter
            indexProgressBar += 1
        }
    
    @objc func updateTimer(){
        if SecondsRemaining > 0 {
            setProgressBar()
            print(SecondsRemaining)
            SecondsRemaining -= 1
        } else {
            topLabel.text = "DONE!"
            indexProgressBar = 0
            playSound()
        }
  }
}
        


       


