//
//  RecordSoundViewController.swift
//  PitchPerfect2
//
//  Created by ludwig vantours on 26/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonConfiguration(recording: false)
        // stopRecordingButton.isEnabled = false;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    @IBAction func recordAudio(_ sender: Any) {
        buttonConfiguration(recording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
      
    }
    
    @IBAction func stopRecordingAudio(_ sender: Any) {
        buttonConfiguration(recording: false)
  
        audioRecorder.stop()
          let audioSession = AVAudioSession.sharedInstance()
          try! audioSession.setActive(false)
        
        
    }
    
    func buttonConfiguration(recording: Bool) {
        if recording {
            recordButton.isEnabled = false;
            stopRecordingButton.isEnabled = true;
            recordingLabel.text =  "Recording in progress...";
        }
        else {
            recordButton.isEnabled = true;
            stopRecordingButton.isEnabled = false;
            recordingLabel.text = "Tap to record";
        }
       
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool){
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url )
        } else {
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            //code
            let playsoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playsoundVC.recordedAudioURL = recordedAudioURL
        }
    }
}

