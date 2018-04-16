//
//  NameVC.swift
//  KaTalk-Settings
//
//  Created by Peichun Tsai on 2018/3/22.
//  Copyright © 2018年 Peichun Tsai. All rights reserved.
//

import UIKit

class NameVC: UIViewController, UITextFieldDelegate {

 
    var userDefaults = UserDefaults.standard
    var textCount = 0
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var editTextField: UITextField!
    

    
    @IBAction func editChanged(_ sender: UITextField) {
        if editTextField.text == userDefaults.string(forKey: "saveName") {
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        else if editTextField.text == "" {
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        else {
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.9707887169, green: 1, blue: 0.4309015426, alpha: 1)
            navigationItem.rightBarButtonItem?.isEnabled = true
            
            textCount = editTextField.text?.characters.count ?? 0
            countLabel.text = "\(textCount)/20"
            }
        }
    
    // 限制字數
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let counter = string.count + (editTextField.text?.count)! - range.length
        if counter > 20 {
            return false
        }
        else {
            return true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Name"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(okTapped))
       
        editTextField.borderStyle = .roundedRect
        editTextField.keyboardType = .default
        editTextField.returnKeyType = .done
        
        editTextField.delegate = self
        
    
    }
    
    @objc func okTapped() {
        // 移除前後空白
        if editTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty == true {
            let alert = UIAlertController(title: "", message: "You cannot set a name consisted of blank spaces only, Please choose another name.", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okBtn)
            present(alert, animated: true, completion: nil)
           
        }
        else {
            let newString = editTextField.text?.trimmingCharacters(in: .whitespaces)
            userDefaults.set(newString, forKey: "saveName")
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        editTextField.text = userDefaults.string(forKey: "saveName")
       
        if editTextField.text == userDefaults.string(forKey: "saveName") {
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        if let userName = userDefaults.string(forKey: "saveName") {
            editTextField.text = userName
            textCount = editTextField.text?.count ?? 0
            countLabel.text = "\(textCount)/20"
        }
    }

    // Keyboard - Done key action
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        okTapped()
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

   

}
