//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Stephen Labedz on 2/17/16.
//  Copyright © 2016 Stephen Labedz. All rights reserved.
//

import UIKit
import AVFoundation

enum Operation: String {
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Mutliply = "*"
    case Empty = "Empty"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var btnFunctionSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    
    var currentOperation: Operation = Operation.Empty
    
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
           try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
            btnSound.volume = 0.05
            
        } catch let err as NSError {
            print(err.debugDescription)
        
        }
        
    }
    
    
    
    
    
    

    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    
    
    
    
    
    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(operatorUsed: Operation.Divide)
    }
    
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(operatorUsed: Operation.Mutliply)
    }
    
    
    @IBAction func onSubtractPressed(sender: UIButton) {
        processOperation(operatorUsed: Operation.Subtract)
    }
    
    
    @IBAction func onAddPressed(sender: UIButton) {
        processOperation(operatorUsed: Operation.Add)
    }
    
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(operatorUsed: currentOperation)
    }
    
    
    
    
    
    
    

    func processOperation(operatorUsed op: Operation) {
        
        playSound()
        
        if currentOperation != Operation.Empty {
            
            // add math calculations here
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                
                if currentOperation == Operation.Mutliply {
                    result = "\(Double(leftValStr)! *  (Double(rightValStr)!))"
                    
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / (Double(rightValStr)!))"
                    
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + (Double(rightValStr)!))"
                    
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - (Double(rightValStr)!))"
                    
                } else if currentOperation == Operation.Mutliply {
                    result = "\(Double(leftValStr)! * (Double(rightValStr)!))"
                    
                }
                
                leftValStr = result
                outputLbl.text = result
                
                
                
            }
            
            currentOperation = op
            
            
        } else {
            // this is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
            
        }
        
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }

}





