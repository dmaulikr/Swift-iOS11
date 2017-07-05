//
//  ViewController.swift
//  CoreMLPrimer
//
//  Created by XeniaH on 7/3/17.
//  Copyright © 2017 xeniah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var model: UISegmentedControl!
    @IBOutlet weak var premiumUpgrades: UISegmentedControl!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var mileageSlider: UISlider!
    @IBOutlet weak var condition: UISegmentedControl!
    @IBOutlet weak var valuation: UILabel!
    
    let cars = Cars()
    
    @IBAction func calculateValue(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formattedMileage = formatter.string(for: mileageSlider.value) ?? "0"
        mileageLabel.text = "MILEAGE (\(formattedMileage) miles)"
        
        // create a prediction by passing in all its input from our UI
        if let prediciton = try? cars.prediction(model: Double(model.selectedSegmentIndex), premium: Double(premiumUpgrades.selectedSegmentIndex), mileage: Double(mileageSlider.value), condition: Double(condition.selectedSegmentIndex))
        {
            let clampedValuation = max(2000, prediciton.price)
            formatter.numberStyle = .currency
            valuation.text = formatter.string(for: clampedValuation)
            
        }else
        {
            valuation.text = "Error"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.setCustomSpacing(70, after: model)
        stackView.setCustomSpacing(70, after: premiumUpgrades)
        stackView.setCustomSpacing(70, after: mileageSlider)
        stackView.setCustomSpacing(60, after: condition)
        
        calculateValue(self)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

