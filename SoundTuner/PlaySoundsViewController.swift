//
//  PlaySoundsViewController.swift
//  SoundTuner
//
//  Created by Miwand Najafe on 2016-07-02.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var chipMunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioEngine: AVAudioEngine!
    var stopTimer: NSTimer!
    var audioFile: AVAudioFile!
    var fullLengthOfAudio: Double?
    
    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Echo, Vader, Reverb }
    
    
    @IBAction func playAudio(sender:UIButton) {
        print("Playing audio")
        
        switch ButtonType.init(rawValue: sender.tag)! {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Echo:
            playSound(pitch: -1000)
        case .Reverb:
            playSound(reverb: true)
        case .Vader:
            playSound(echo: true)
        }
        configureUI(PlayingState.Playing)
    }
    
    @IBAction func stopPlayingAudio(sender:UIButton) {
        print("Stop playing audio")
        stopAudio()
    }
    
    @IBAction func pauseAudio(sender:UIButton) {
        print("Pausing audio")
        pauseAudio()
    }
    
    @IBAction func resumeAudio(sender:UIButton) {
        print("Resuming audio")
        resumeAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(PlayingState.NotPlaying)
    }
    


}
