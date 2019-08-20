//
//  SettingsViewController.swift
//  MVC+Delegation-Review-Lab
//
//  Created by Sunni Tang on 8/19/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: - Variables and Constants
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var previewFontLabel: UILabel!
    
    // creates optional instance of protocol FontChangeable
    var fontChange: FontChangeable?
    var startingFontSize = Font.startingFontSize
    
    // creates property observer that applies the delegate method and calls function to update labels based on that method
    var newFontSize: Int! {
        didSet {
            fontChange?.changeCurrentFontSize(to: newFontSize)
            updateLabel()
        }
    }
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the initial font size when settingsVC is first loaded to startingFontSize
        newFontSize = startingFontSize
    }
    

    // MARK: IBActions and UI Functions
    @IBAction func slideChangeFontSize(_ sender: UISlider) {
        newFontSize = Int(sender.value)
    }
    
    @IBAction func stepChangeFontSize(_ sender: UIStepper) {
        newFontSize = Int(sender.value)
    }
    
    // Updates label to be used in property observer, newFontSize
    func updateLabel() {
        // optional binding to guard for if newFontSize is nil (no change)
        if let newFontSize = newFontSize {
            previewFontLabel.text = "Preview Font Size: \(newFontSize)"
        } else {
            previewFontLabel.text = "Preview Font Size: \(startingFontSize)"
        }
        // updates the slider and stepper values to the newFontSize
        slider.value = Float(newFontSize)
        stepper.value = Double(newFontSize)
    }
    
}
