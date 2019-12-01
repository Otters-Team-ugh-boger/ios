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
  var timer: Timer?
  
  let notifications = Notifications()
  let userDefaults = UserDefaults.standard
  
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
  
  @IBAction func runAlarm(_ sender: UIButton) {
    
    RequestManager.shared.postPaymentsRules { completion in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          self.userDefaults.set(result.id, forKey: "PaymentsRulesId")
          print("postPaymentsRules")
          print(result)
        case .failure(let error):
          print(error)
        }
      }
    }
    
    let paymentsRules = self.userDefaults.integer(forKey: "PaymentsRulesId")
    RequestManager.shared.postPaymentsRulesTriger(id: paymentsRules) { completion in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          print("trigger")
          print(result)
        case .failure(let error):
          print(error)
        }
      }
    }
    
    if let time = alarmClockLabelText.text
    {
      notifications.scheduleNotification(time: dateFormatter(string: time)) { completionHandler in
        // to do something
      }
    }
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
  
  func createTimer() {
    if timer == nil {
      timer = Timer.scheduledTimer(timeInterval: 1.0,
                                   target: self,
                                   selector: #selector(run),
                                   userInfo: nil,
                                   repeats: false)
    }
  }
  
  @objc func run(_ timer: AnyObject) {
        print("Do your remaining stuff here...")
  }
  
}

