//
//  ViewController.swift
//  AllSystemSound
//
//  Created by KyXu on 2017/8/27.
//  Copyright © 2017年 KyXu. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerView: UIPickerView!
    
    lazy var allSoundId: [(SystemSoundID, String)] = {
        let path = Bundle.main.path(forResource: "sound", ofType: "txt")
        var txtContent = ""
        do {
            txtContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch _ {}
        let arr = txtContent.components(separatedBy: CharacterSet.newlines)
        var result = [(SystemSoundID, String)]()
        for i in 0..<arr.count-4 {
            if arr[i] == "<tr>" {
                let id = arr[i+1].components(separatedBy: " ")[1]
                let str = arr[i+4].components(separatedBy: " ")[1]
                result.append((UInt32(id)!,str))
            }
        }
        return result
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allSoundId.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let tuple = allSoundId[row]
        return "\(tuple.0)  \(tuple.1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        AudioServicesPlaySystemSound(allSoundId[row].0)
    }
}

