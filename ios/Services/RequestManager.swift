//
//  RequestManager.swift
//  ios
//
//  Created by vladislav on 30.11.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

class RequestManager {
  
  private let urlPath = "https://ot-ugh-boger.herokuapp.com"
  
  static var shared = RequestManager()
  private init() {}
  
  func SignIn(userName: String, password: String, completionHandler: @escaping(Result<String>) -> Void) {
    let url = "\(urlPath)/user/token"
    let user = User(name: userName, password: password)
    
    APIManager.shared.postData(url: url, data: user) { (completion: Result<String>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          completionHandler(.success(result))
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
}
