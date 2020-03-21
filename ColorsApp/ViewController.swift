//
//  ViewController.swift
//  ColorsApp
//
//  Created by Павел Борисевич on 3/21/20.
//  Copyright © 2020 Павел Борисевич. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLable: UILabel!
    @IBOutlet var greenLable: UILabel!
    @IBOutlet var blueLable: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
       
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        setColor()
        setValueForLabel()
        setValueForTextField()
        
        addDoneButtonTo(redTextField)
        addDoneButtonTo(greenTextField)
        addDoneButtonTo(blueTextField)
        
        
    }
     // Изменение цветов слайдеров
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redLable.text = string(from: sender)
            redTextField.text = string(from: sender)
        case 1:
            greenLable.text = string(from: sender)
            greenTextField.text = string(from: sender)
        case 2:
            blueLable.text = string(from: sender)
            blueTextField.text = string(from: sender)
        default:
            break
        }
         setColor()
    }
    
    // Цвет вью
      private func setColor() {
          colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                              green: CGFloat(greenSlider.value),
                                              blue: CGFloat(blueSlider.value),
                                              alpha: 1)
      }
      
      private func setValueForLabel() {
          redLable.text = string(from: redSlider)
          greenLable.text = string(from: greenSlider)
          blueLable.text = string(from: blueSlider)
      }
      
      private func setValueForTextField() {
          redTextField.text = string(from: redSlider)
          greenTextField.text = string(from: greenSlider)
          blueTextField.text = string(from: blueSlider)
      }
    
    // Значения RGB
       private func string(from slider: UISlider) -> String {
           return String(format: "%.2f", slider.value)
       }
    }

    extension ViewController: UITextFieldDelegate {
        
        // Скрываем клавиатуру нажатием на "Done"
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        // Скрытие клавиатуры по тапу за пределами Text View
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            
            view.endEditing(true) // Скрывает клавиатуру, вызванную для любого объекта
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            guard let text = textField.text else { return }
            
            if let currentValue = Float(text) {
                
                switch textField.tag {
                case 0: redSlider.value = currentValue
                case 1: greenSlider.value = currentValue
                case 2: blueSlider.value = currentValue
                default: break
                }
                
                setColor()
                setValueForLabel()
            } else {
                showAlert(title: "Wrong format!", message: "Please enter correct value")
            }
        }
    }

    extension ViewController {
        
        // Метод для отображения кнопки "Готово" на цифровой клавиатуре
        private func addDoneButtonTo(_ textField: UITextField) {
            
            let keyboardToolbar = UIToolbar()
            textField.inputAccessoryView = keyboardToolbar
            keyboardToolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title:"Done",
                                             style: .done,
                                             target: self,
                                             action: #selector(didTapDone))
            
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil,
                                                action: nil)
            
            
            
            keyboardToolbar.items = [flexBarButton, doneButton]
        }
        
        @objc private func didTapDone() {
            view.endEditing(true)
        }
        
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
}

