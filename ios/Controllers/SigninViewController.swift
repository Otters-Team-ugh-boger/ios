//
//  SigninViewController.swift
//  ios
//
//  Created by vladislav on 30.11.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
  @IBOutlet weak var userNameLabelText: UITextField!
  @IBOutlet weak var passwordLabelText: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  @IBAction func signIn(_ sender: UIButton) {
    if let userName = self.userNameLabelText.text, let password = self.passwordLabelText.text {
      RequestManager.shared.SignIn(userName: userName, password: password) { completion in
        DispatchQueue.main.async {
          switch completion {
          case .success(let result):
            print(result)
          case .failure(let error):
            print(error)
          }
        }
      }
    } else {
      print("Error: UserName or Password field is empty")
    }
  }

}
