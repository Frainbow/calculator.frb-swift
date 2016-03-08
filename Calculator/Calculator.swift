//
//  Calculator.swift
//  Calculator
//
//  Created by martin on 2016/3/7.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation

class Calculator {

    enum DigitBtn: String {
        case zero   = "0"
        case one    = "1"
        case two    = "2"
        case three  = "3"
        case four   = "4"
        case five   = "5"
        case six    = "6"
        case seven  = "7"
        case eight  = "8"
        case nine   = "9"
        case point  = "."
    }

    enum OperatorBtn: String {
        case add        = "+"
        case minus      = "-"
        case multiply   = "*"
        case divide     = "/"
    }

    enum FunctionBtn: String {
        case result     = "="
    }

    var input: String = ""
    var output: String?
    var number1: Double?
    var number2: Double?
    var optor: OperatorBtn?
    var isCalculated: Bool = false

    func inputDigit(digitBtn: DigitBtn) -> String? {
        
        // skip if point has existed in a number
        if (digitBtn == .point && input.rangeOfString(DigitBtn.point.rawValue) != nil) {
            return nil
        }

        // reset previous output
        if isCalculated && input.characters.count == 0 {
            clear()
        }

        // append the digit to input string
        input += digitBtn.rawValue

        return input
    }

    func inputOperator(operatorBtn: OperatorBtn) -> String? {

        // set number1 as zero if no digit is input before operating
        if number1 == nil && Double(input) == nil {
            number1 = 0
        }

        // operate numbers if both have values
        if let num1 = number1, op = optor, num = Double(input) {

            let (outputDouble, outputString) = calculate(num1, op, num)

            output = outputString
            number1 = outputDouble
        }

        // save input string to number1 if no operator is input before
        else if let num = Double(input) {
            output = input
            number1 = num
        }

        input = ""
        number2 = nil
        optor = operatorBtn
        isCalculated = false

        return output
    }

    func getResult() -> String? {

        if let num1 = number1, op = optor {
            var num2: Double = 0
            
            // input sequence: 1 + 1 =
            if let num = Double(input) {
                num2 = num
            }
            // input sequence: 1 + 1 = =
            else if let num = number2 {
                num2 = num
            }
            // input sequence: 1 + =
            else if let num = number1 {
                num2 = num
            }
            else {
                return nil
            }

            let (outputDouble, outputString) = calculate(num1, op, num2)

            input = ""
            output = outputString
            number1 = outputDouble
            number2 = num2
            isCalculated = true
        }

        return output
    }
    
    func calculate(num1: Double, _ optor: OperatorBtn, _ num2: Double) -> (Double, String?) {
        var result: Double

        switch optor {
        case .add:
            result = num1 + num2
        case .minus:
            result = num1 - num2
        case .multiply:
            result = num1 * num2
        case .divide:
            result = num1 / num2
        }

        let precision: Double = 1000 * 1000 * 1000 * 1000

        result = round(result * precision) / precision

        return result % 1 == 0 ? (result, String(Int(result))) : (result, Optional(String(result)))
    }

    func clear() -> String? {
        input = ""
        output = nil
        number1 = nil
        number2 = nil
        optor = nil
        isCalculated = false

        return "0"
    }
}
