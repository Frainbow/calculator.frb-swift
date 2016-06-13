//
//  ViewController.swift
//  Calculator
//
//  Created by martin on 2016/3/5.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var outputLabel: UILabel!
    
    let calculator = Calculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pushCalcBtn(sender: AnyObject) {
        let digitBtn = sender as? UIButton

        if let title = digitBtn?.titleLabel?.text {
            var output: String?

            if let btn = Calculator.DigitBtn(rawValue: title) {
                output = calculator.onClickDigitBtn(btn)
            }
            else if let btn = Calculator.OperatorBtn(rawValue: title) {
                output = calculator.onClickOperatorBtn(btn)
            }
            else if let btn = Calculator.FunctionBtn(rawValue: title) {
                output = calculator.onClickFunctionBtn(btn)
            }

            if let text = output {
                outputLabel.text = text;
            }
        }
    }
}

