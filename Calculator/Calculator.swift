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
        case multiply   = "×"
        case divide     = "÷"
        case result     = "="
    }

    enum FunctionBtn: String {
        case clearAll   = "AC"
        case toggleSign = "+/-"
        case percent    = "%"
    }

    var text: String = "0"
    var value: Double = 0
    var operand1: Double? = nil
    var optor: OperatorBtn? = nil
    var operand2: Double? = nil
    var isNewValue: Bool = true
    var isNewStatement: Bool = true

    func onClickDigitBtn(digitBtn: DigitBtn) -> String? {

        if (isNewValue || isNewStatement) {
            text = "0"
            value = 0
        }

        if (isNewStatement) {
            operand1 = nil
            optor = nil
            operand2 = nil
        }

        if (digitBtn == .point && text.rangeOfString(DigitBtn.point.rawValue) != nil) {
            // more than one point is invalid
            return nil
        }

        if (digitBtn != .point && text == "0") {
            // remove the leading zero
            if let doubleValue = Double(digitBtn.rawValue) {
                text = digitBtn.rawValue
                value = doubleValue
            }
        }
        else {
            // append digit to text value
            if let doubleValue = Double(text + digitBtn.rawValue) {
                text = text + digitBtn.rawValue
                value = doubleValue
            }
        }

        isNewValue = false
        isNewStatement = false

        return text
    }

    func onClickOperatorBtn(operatorBtn: OperatorBtn) -> String? {

        if operand1 == nil && operatorBtn != .result {
            operand1 = value
        }

        if operand2 == nil {
            operand2 = value
        }

        if let operand1 = operand1, optor = optor, operand2 = operand2 {

            if (!isNewStatement || operatorBtn == .result) {

                switch (optor) {
                case .add:
                    value = operand1 + operand2
                case .minus:
                    value = operand1 - operand2
                case .multiply:
                    value = operand1 * operand2
                case .divide:
                    value = operand1 / operand2
                default:
                    break
                }

                let (doubleValue, stringValue) = self.adjustValue(value)

                self.operand1 = doubleValue
                self.text = stringValue
                self.value = doubleValue
            }
        }

        if (operatorBtn != .result) {
            optor = operatorBtn
            operand2 = nil
        }

        isNewValue = true
        isNewStatement = (operatorBtn == .result)
        
        return text
    }

    func onClickFunctionBtn(functionBtn: FunctionBtn) -> String? {
        
        switch functionBtn {
        case .clearAll:
            text = "0"
            value = 0
            operand1 = nil
            optor = nil
            operand2 = nil
            isNewValue = true
            isNewStatement = true
        case .toggleSign:
            (value, text) = self.adjustValue(value * (-1))

            if isNewStatement {
                operand1 = value
            }
        case .percent:
            (value, text) = self.adjustValue(value * (0.01))

            if isNewStatement {
                operand1 = value
            }
        }

        return text
    }
    
    func adjustValue(value: Double) -> (Double, String) {
        
        var stringValue = String(value)
        
        if value % 1 == 0 {
            stringValue = stringValue.characters.split{ $0 == "." }.map(String.init)[0]
        }
        
        return (value, stringValue)
    }
}
