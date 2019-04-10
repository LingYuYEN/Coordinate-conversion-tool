//
//  ViewController.swift
//  Coordinate conversion tool
//
//  Created by Louis on 2019/4/3.
//  Copyright © 2019 Louis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    
    @IBOutlet weak var xTextField_1: UITextField!
    @IBOutlet weak var yTextField_1: UITextField!
    
    @IBOutlet weak var xTextField_2: UITextField!
    @IBOutlet weak var yTextField_2: UITextField!
    
    @IBOutlet weak var xTextField_3: UITextField!
    @IBOutlet weak var yTextField_3: UITextField!
    
    @IBOutlet weak var xTextField_4: UITextField!
    @IBOutlet weak var yTextField_4: UITextField!
    
    @IBOutlet weak var lonTextField_1: UITextField!
    @IBOutlet weak var lonMinTextField_1: UITextField!
    @IBOutlet weak var lonSecTextField_1: UITextField!
    @IBOutlet weak var latTextField_1: UITextField!
    @IBOutlet weak var latMinTextField_1: UITextField!
    @IBOutlet weak var latSecTextField_1: UITextField!
    
    @IBOutlet weak var lonTextField_2: UITextField!
    @IBOutlet weak var lonMinTextField_2: UITextField!
    @IBOutlet weak var lonSecTextField_2: UITextField!
    @IBOutlet weak var latTextField_2: UITextField!
    @IBOutlet weak var latMinTextField_2: UITextField!
    @IBOutlet weak var latSecTextField_2: UITextField!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var resultTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTextView.text = "範例：\nTWD67二度分帶坐標值 :　　 　306134.775, 2769899.764\nTWD97二度分帶坐標值 :　 　　306965.392, 2769696.069\nTWD67經緯度坐標值 :　　　 　121.556275186,25.036089073\nTWD97(WGS84)經緯度坐標值 : 121.5645,25.034305556"
        scrollView.layer.cornerRadius = 10
        resultTextView.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        
        guard let infokey = notification.userInfo?[UIResponder.keyboardIsLocalUserInfoKey] else {return}
        guard let rectValue = (infokey as AnyObject).cgRectValue else {return}
        let keyboardFrame = self.view.convert(rectValue, from: nil)
        self.constraint.constant = keyboardFrame.size.height + 250
        self.constraint.constant = keyboardFrame.size.height + 500
    }
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        self.constraint.constant = 170
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func onStartButtonAction(_ sender: Any) {
        self.resultTextView.text = ""
        // 1.取得TWD67並show出轉TWD97的值
        if let result67To97X = Double(xTextField_1.text!),let result67To97Y = Double(yTextField_1.text!) {
            resultTextView.text += "TWD67二維坐標轉為TWD97二維坐標值是：\(TWD97_TM2(x67: result67To97X, y67: result67To97Y))" + "\n"
        }
        // 2.取得TWD97並show出轉TWD67的值
        if let result97To67X = Double(xTextField_2.text!), let result97To67Y = Double(yTextField_2.text!){
            resultTextView.text += "TWD97二維坐標轉為TWD67二維坐標值是：\(TWD67_TM2(x97: result97To67X, y97: result97To67Y))" + "\n"
        }
        // 3.取得TWD67_二維並show出轉TWD67_經緯度_十進制的值
        if let resultTWD67_TM2ToDecimal_X = Double(xTextField_3.text!), let resultTWD67_TM2ToDecimal_Y = Double(yTextField_3.text!) {
            resultTextView.text += "TWD67二維坐標轉為經緯度(十進制)的值是：\(TWD67_TM2ToDecimal(xValue: resultTWD67_TM2ToDecimal_X, yValue: resultTWD67_TM2ToDecimal_Y))" + "\n"
        }
        // 4.取得TWD97_二維並show出轉TWD97_經緯度_十進制的值
        if let resultTWD97_TM2ToDecimal_X = Double(xTextField_4.text!), let resultTWD97_TM2ToDecimal_Y = Double(yTextField_4.text!) {
            resultTextView.text += "TWD97二維坐標轉為經緯度(十進制)的值是：\(TWD97_TM2ToDecimal(xValue: resultTWD97_TM2ToDecimal_X, yValue: resultTWD97_TM2ToDecimal_Y))" + "\n"
        }
        // 5.取得TWD67_經緯度並show出轉TWD67_經緯度_十進制的值
        if let resultTWD67ToDecimalLon = Double(lonTextField_1.text!), let resultTWD67ToDecimalLonMin = Double(lonMinTextField_1.text!), let resultTWD67ToDecimalLonSec = Double(lonSecTextField_1.text!), let resultTWD67ToDecimalLat = Double(latTextField_1.text!),let resultTWD67ToDecimalLatMin = Double(latMinTextField_1.text!),let resultTWD67ToDecimalLatSec = Double(latSecTextField_1.text!){
            resultTextView.text += "TWD67經緯度轉為經緯度(十進制)的值是：\(TWDToDecimal(xDecimal: resultTWD67ToDecimalLon, xMinutes: resultTWD67ToDecimalLonMin, xSeconds: resultTWD67ToDecimalLonSec, yDecimal: resultTWD67ToDecimalLat, yMinutes: resultTWD67ToDecimalLatMin, ySeconds: resultTWD67ToDecimalLatSec))" + "\n"
        }
        // 6.取得TWD97_經緯度並show出轉TWD97_經緯度_十進制的值
        if let resultTWD97ToDecimalLon = Double(lonTextField_2.text!), let resultTWD97ToDecimalLonMin = Double(lonMinTextField_2.text!), let resultTWD97ToDecimalLonSec = Double(lonSecTextField_2.text!), let resultTWD97ToDecimalLat = Double(latTextField_2.text!), let resultTWD97ToDecimalLatMin = Double(latMinTextField_2.text!), let resultTWD97ToDecimalLatSec = Double(latSecTextField_2.text!){
            resultTextView.text += "TWD97經緯度轉為經緯度(十進制)的值是：\(TWDToDecimal(xDecimal: resultTWD97ToDecimalLon, xMinutes: resultTWD97ToDecimalLonMin, xSeconds: resultTWD97ToDecimalLonSec, yDecimal: resultTWD97ToDecimalLat, yMinutes: resultTWD97ToDecimalLatMin, ySeconds: resultTWD97ToDecimalLatSec))" + "\n"
        }
        
        
        
        resultTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if resultTextView.text == "" {
            resultTextView.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            resultTextView.text = "請選擇輸入一組欄位 或 請輸入數值" + "\n"
        }
    }
    @IBAction func onClearButtonAction(_ sender: Any) {
        resultTextView.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.resultTextView.text = "範例：\nTWD67二度分帶坐標值 :　　 　306134.775, 2769899.764\nTWD97二度分帶坐標值 :　 　　306965.392, 2769696.069\nTWD67經緯度坐標值 :　　　 　121.556275186,25.036089073\nTWD97(WGS84)經緯度坐標值 : 121.5645,25.034305556"
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isContainsSpaceCharacters() {
            textField.placeholder = "請輸入數值，不需空格"
            return false
        }
        if string.isContainsChineseCharacters() {
            textField.placeholder = "請輸入數值，不可中文"
            return false
        }
        if string.isContainsEnglishCharacters() {
            textField.placeholder = "請輸入數值，不可字母"
            return false
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    
}

extension String {
    // 檢查是否含有中文字元
    func isContainsChineseCharacters() -> Bool {
        for scalar in self.unicodeScalars {
            if scalar.value >= 19968 && scalar.value <= 171941 {
                return true
            }
        }
        return false
    }
    // 檢查是否含有中文字元
    func isContainsEnglishCharacters() -> Bool {
        for scalar in self.unicodeScalars {
            if scalar.value >= 65 && scalar.value <= 90 || scalar.value >= 97 && scalar.value <= 122 {
                return true
            }
        }
        return false
    }
    // 檢查是否含有空白字元
    func isContainsSpaceCharacters() -> Bool {
        for scalar in self.unicodeScalars {
            if scalar.value == 32 {
                return true
            }
        }
        return false
    }
}
