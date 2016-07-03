//
//  RecordSoundViewController.swift
//  SoundTuner
//
//  Created by Miwand Najafe on 2016-07-02.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var recordingStatus = false
    
    let audioSession = AVAudioSession.sharedInstance()
    
    @IBAction func recordAudio(sender: UIButton) {
        print("Recording audio")
        setupAudioRecorder()
        changeRecordingStatus()
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        print("Stop recording audio")
        changeRecordingStatus()
        audioRecorder.stop()
        try! audioSession.setActive(false)
    }
    
    func changeRecordingStatus() {
        recordingStatus = !recordingStatus
        changeRecordLabel()
        recordButton.enabled = !recordingStatus
        stopButton.enabled = recordingStatus
    }
    
    func changeRecordLabel() {
        recordLabel.text = recordingStatus ? "Recording in progress": "Tap record to start recording"
    }
    
    func setupAudioRecorder() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let fileName = "recordAudio.wav"
        let fileArray = [dirPath,fileName]
        
        let filePath = NSURL.fileURLWithPathComponents(fileArray)
        print(filePath)
        try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        stopButton.enabled = false
        changeRecordLabel()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Trying to save audio")
        if flag {
            print("Audio recording successfully saved")
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print("Failed to save recorded audio")
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let playRecordedSoundVC = segue.destinationViewController as! PlaySoundsViewController
            playRecordedSoundVC.recordedAudioURL = sender as! NSURL
        }
    }
}
