//
//  ViewController.swift
//  llnkedinlearning
//
//  Created by Adam Jean-Laurent on 7/20/19.
//  Copyright © 2019 Adam Jean-Laurent. All rights reserved.
//

import UIKit

enum Modes {
    case not_set
    case addition
    case subtraction
    case multiplication
}

class ViewController: UIViewController {
    @IBOutlet weak var headingLabel: UILabel!
    
    var labelString:String = "0"
    var currentMode:Modes = .not_set
    var savedNum:Int = 0
    var lastButtonWasMode:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeModes(newMode: .addition)
    }
    
    @IBAction func didPressSubtract(_ sender: Any) {
        changeModes(newMode: .subtraction)
    }
    
    @IBAction func didPressMultiply(_ sender: Any) {
         changeModes(newMode: .multiplication)
    }
    
    @IBAction func didPressEquals(_ sender: Any) {
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        if(currentMode == .not_set || lastButtonWasMode){
            return
        }
        
        if(currentMode == .addition) {
            savedNum += labelInt
        }
        
        else if(currentMode == .subtraction) {
            savedNum -= labelInt
        }
        else if (currentMode == .multiplication) {
            savedNum *= labelInt
        }
        
        currentMode = .not_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        labelString = "0"
        currentMode = .not_set
        savedNum = 0
        lastButtonWasMode = false
        updateText()
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        // value of text for the button that was pressed
        let buttonValue:String? = sender.titleLabel?.text
        
        if(lastButtonWasMode) {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        // append button Value to label string
        labelString = labelString.appending(buttonValue!)
        updateText()
    }
    
    func updateText(){
        // integer conversino removes case of leading zeroes
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        
        if(currentMode == .not_set){
            savedNum = labelInt
        }
        
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: labelInt)
        
        headingLabel.text = formatter.string(from: num)
    }
    
    func changeModes(newMode:Modes) {
        if(savedNum == 0){
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
}
