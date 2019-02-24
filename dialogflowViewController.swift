//
//  dialogflowViewController.swift
//  Servetheneed
//
//  Created by HARIKA JETTI on 2/24/19.
//  Copyright © 2019 HARIKA JETTI. All rights reserved.
//

import UIKit
import Speech
import ApiAI
import AudioToolbox
import AudioUnit
import FirebaseAuth
import FirebaseFirestore

class dialogflowViewController: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet weak var microphonebutton: UIButton!
    
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var chipResponse: UILabel!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var activityIndicator = UIActivityIndicatorView()
    let loadingView = UIView()
    let loadingLabel = UILabel()
    let loadingTextLabel = UILabel()
    var decount = 0
    var a_count = 0
    var b_count = 0
    var c_count = 0
    var docRef : DocumentReference!
    let uid = Auth.auth().currentUser?.uid
    var db: Firestore!
    var a = ""
    
    
    @IBAction func sendMessage(_ sender: Any) {
        let request = ApiAI.shared().textRequest()
        
        if let text = self.messageField.text, text != "" {
            print("text1",text)
            request?.query = text
        } else {
            return
        }
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            if let textResponse = response.result.fulfillment.speech {
                self.speechAndText(text: textResponse)
            }
        }, failure: { (request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        messageField.text = ""
    
    }
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func speechAndText(text: String) {
        print("text", text)
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.chipResponse.text = text
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
