//
//  PaymentViewController.swift
//  ios
//
//  Created by vladislav on 30.11.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
  
  @IBOutlet weak var privateKeyLabelText: UITextField!
  
  let userDefaults = UserDefaults.standard
  
  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
  }
  
  @IBAction func sendPrivateKey(_ sender: UIButton) {
    if let privateKey = self.privateKeyLabelText.text {
      RequestManager.shared.sendPrivateKey(privateKey: privateKey) { completion in
        DispatchQueue.main.async {
          switch completion {
          case .success(let result):
            self.userDefaults.set(result.id, forKey: "PaymentMethodId")
            print(result.id)
          case .failure(let error):
            print(error)
          }
        }
      }
    } else {
      print("Private key field is empty")
    }
  }
  

}
