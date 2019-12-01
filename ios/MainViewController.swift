//
//  ViewController.swift
//  ios
//
//  Created by vladislav on 30.11.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet weak var alarmClockLabelText: UITextField!
  private var datePicker: UIDatePicker?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setting of Data Picker
      datePicker = UIDatePicker()
      datePicker?.datePickerMode = .time
      alarmClockLabelText.inputView = datePicker
      
      // Create a toolbar
      let toolbar = UIToolbar()
      toolbar.sizeToFit()
      let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeDatePicker))
      let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      toolbar.setItems([flexSpace, doneButton], animated: true)
      alarmClockLabelText.inputAccessoryView = toolbar
    
      // Change value by Date Picker
      datePicker?.addTarget(self, action: #selector(dateChange), for: .valueChanged)
  }
  
  
  
  // MARK: - Helpers
  
  @objc func dateChange() {
     let formatter = DateFormatter()
     formatter.dateFormat = "HH:mm"
     
     if let time = datePicker?.date {
       alarmClockLabelText.text = formatter.string(from: time)
     } else {
       alarmClockLabelText.text = "None"
     }
   }
   
   @objc func closeDatePicker() {
     view.endEditing(true)
   }
   
   func dateFormatter(string: String) -> Date {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "HH:mm"
     
     return dateFormatter.date(from: string)!
   }
  
}

