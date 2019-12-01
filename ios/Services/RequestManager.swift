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
  
  func sendPrivateKey(privateKey: String, completionHandler: @escaping(Result<ResponsePaymentMethod>) -> Void) {
    let url = "\(urlPath)/payments/methods"
    let privateKey = RequestPaymentMethod(type: "ETH", privateKey: privateKey)
    
    APIManager.shared.postData(url: url, data: privateKey) { (completion: Result<Data>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            let json = try jsonDecoder.decode(ResponsePaymentMethod.self, from: result)
            
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
  
  func postPaymentsRules(completionHandler: @escaping(Result<ResponsePaymentRule>) -> Void) {
    let url = "\(urlPath)/payments/rules"
    let foundationId = userDefaults.integer(forKey: "FoundationId")
    let paymentMethodId = userDefaults.integer(forKey: "PaymentMethodId")
    let paymentsRules = RequestPaymentRule(paymentMethodId: paymentMethodId, foundationId: foundationId, amount: "0.04")
    
    APIManager.shared.postData(url: url, data: paymentsRules) { (completion: Result<Data>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            let json = try jsonDecoder.decode(ResponsePaymentRule.self, from: result)
            
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
  
  func postPaymentsRulesTriger(id: Int, completionHandler: @escaping(Result<Transaction>) -> Void) {
    let url = "\(urlPath)/payments/rules/\(id)/trigger"
    
    APIManager.shared.postData(url: url, data: id) { (completion: Result<Data>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            let json = try jsonDecoder.decode(Transaction.self, from: result)
            
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
