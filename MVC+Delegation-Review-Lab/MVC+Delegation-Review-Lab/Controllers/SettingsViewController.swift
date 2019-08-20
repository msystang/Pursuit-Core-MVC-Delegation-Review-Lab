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
    
    var fontChange: FontChangeable?
    var startingFontSize = Font.startingFontSize
    var newFontSize: Int! {
        didSet {
            fontChange?.changeCurrentFontSize(to: newFontSize)
            updateLabel()
        }
    }
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        newFontSize = startingFontSize
    }
    

    // MARK: IBActions and UI Functions
    @IBAction func slideChangeFontSize(_ sender: UISlider) {
        newFontSize = Int(sender.value)
    }
    
    @IBAction func stepChangeFontSize(_ sender: UIStepper) {
        newFontSize = Int(sender.value)
    }
    
    func updateLabel() {
        if let newFontSize = newFontSize {
            previewFontLabel.text = "Preview Font Size: \(newFontSize)"
        } else {
            previewFontLabel.text = "Preview Font Size: \(startingFontSize)"
        }
        slider.value = Float(newFontSize)
        stepper.value = Double(newFontSize)
    }
    
}
