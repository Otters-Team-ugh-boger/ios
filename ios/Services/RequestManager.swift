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
  let userDefaults = UserDefaults.standard
  
  static var shared = RequestManager()
  private init() {}
  
  func signIn(userName: String, password: String, completionHandler: @escaping(Result<UserToken>) -> Void) {
    let url = "\(urlPath)/user/token"
    let user = User(name: userName, password: password)
    
    APIManager.shared.postData(url: url, data: user) { (completion: Result<Data>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            let json = try jsonDecoder.decode(UserToken.self, from: result)
            
            completionHandler(.success(json))
          } catch let error{
            completionHandler(.failure(error.localizedDescription))
          }
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
//  func signUp(userName: String, password: String, completionHandler: @escaping(Result<User>) -> Void) {
//    let url = "\(urlPath)/user/create"
//    let user = User(name: userName, password: password)
//
//    APIManager.shared.postData(url: url, data: user) { (completion: Result<Data>) in
//      DispatchQueue.main.async {
//        switch completion {
//        case .success(let result):
//          completionHandler(.success(result))
//        case .failure(let error):
//          completionHandler(.failure(error))
//        }
//      }
//    }
//  }
  
  func sendPrivateKey(privateKey: String, completionHandler: @escaping(Result<PaymentMethod>) -> Void) {
    let url = "\(urlPath)/payments/methods"
    let privateKey = PrivateKey(privateKey: privateKey, type: "ETH")
    
    APIManager.shared.postData(url: url, data: privateKey) { (completion: Result<Data>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            let json = try jsonDecoder.decode(PaymentMethod.self, from: result)
            
            completionHandler(.success(json))
          } catch let error{
            completionHandler(.failure(error.localizedDescription))
          }
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
  func getFoundation(completionHandler: @escaping(Result<[Foundation]>) -> Void) {
    let url = "\(urlPath)/foundations"
    
    APIManager.shared.getData(url: url) { (completion: Result<[Foundation]>) in
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
  
  func postPaymentsRules(completionHandler: @escaping(Result<PaymentMethod>) -> Void) {
    let url = "\(urlPath)/payments/methods"
    let foundationId = userDefaults.integer(forKey: "FoundationId")
    let paymentMethodId = userDefaults.integer(forKey: "PaymentMethodId")
    let paymentsRules = PaymentRule(paymentMethodId: paymentMethodId, foundationId: foundationId, amount: 150)
    
    APIManager.shared.postData(url: url, data: paymentsRules) { (completion: Result<Data>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            let json = try jsonDecoder.decode(PaymentMethod.self, from: result)
            
            completionHandler(.success(json))
          } catch let error{
            completionHandler(.failure(error.localizedDescription))
          }
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
}
