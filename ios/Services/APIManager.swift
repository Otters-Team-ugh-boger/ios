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
  
  let userDefaults = UserDefaults.standard
  
  static var shared = APIManager()
  private init() {}
  
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
  
  func postData<T: Codable>(url: String, data: T, completion: @escaping(Result<Data>) -> Void) {
    guard let url = URL(string: url) else { return completion(.failure("Invalid URL")) }
    let token = userDefaults.string(forKey: "Token")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("\(token)", forHTTPHeaderField: "Authorization")
    
    guard let postData = try? JSONEncoder().encode(data) else { return completion(.failure("JSON encoder error"))}
    
    URLSession.shared.uploadTask(with: request, from: postData) { (data, response, error) in
      guard error == nil else { return completion(.failure(error!.localizedDescription)) }
      
      guard let response = response as? HTTPURLResponse,
          (200...299).contains(response.statusCode) else {
          return completion(.failure("Server error"))
      }
      
      guard let mimeType = response.mimeType,
        mimeType == "application/json", let data = data else { return completion(.failure(error!.localizedDescription))}
      
      completion(.success(data))
      
    }.resume()
  }
  
}
