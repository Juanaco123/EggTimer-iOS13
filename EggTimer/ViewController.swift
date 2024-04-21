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
    
    let eggTimes : [String : Int] = [
        "Soft": 3, //300
        "Medium": 4, //480
        "Hard": 7 //720
    ]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton){
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.secondsPassed < self.totalTime {
                
                print ("\(self.secondsPassed) seconds")
                
                self.secondsPassed += 1
                
                let percentageProgress = Float(self.secondsPassed) / Float(self.totalTime)
                
                
                self.progressBar.setProgress(percentageProgress, animated: true)
                
            } else {
                timer.invalidate()
                self.titleLabel.text = "Done!"
                self.playSound(soundName: "alarm_sound")
            }
        }
        print(secondsPassed)
      
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
