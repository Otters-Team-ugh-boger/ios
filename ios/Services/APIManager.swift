//
//  APIManager.swift
//  ios
//
//  Created by vladislav on 30.11.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

enum Result<T> {
  case success(T)
  case failure(String)
}

class APIManager {
  
  func getData<T: Decodable>(url: String, completion: @escaping(Result<T>) -> Void) {
    guard let url = URL(string: url) else { return completion(.failure("Invalid URL")) }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else { return completion(.failure(error!.localizedDescription)) }
      guard let data = data else { return completion(.failure(error!.localizedDescription)) }
      
      do {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let json = try jsonDecoder.decode(T.self, from: data)
        completion(.success(json))
        
      } catch let error {
        completion(.failure(error.localizedDescription))
      }
    }.resume()
  }
  
  func postData<T: Encodable>(url: String, data: T) {
    guard let url = URL(string: url) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    guard let postData = try? JSONEncoder().encode(data) else { return }
    
    URLSession.shared.uploadTask(with: request, from: postData) { (responseData, response, error) in
      guard error == nil else { return }
      
      
      
    }.resume()
  }
  
}
