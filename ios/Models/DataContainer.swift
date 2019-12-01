//
//  DataContainer.swift
//  ios
//
//  Created by vladislav on 30.11.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


struct User: Codable {
  var name: String
  var password: String
}

struct PrivateKey: Codable {
  var privateKey: String
  var type: String
}

// MARK: - Response models
struct UserToken: Decodable {
  var userId: Int
  var token: String
}

struct Foundation: Decodable {
  var id: Int
  var name: String
  var description: String
  var paymentAdress: String
}

struct PaymentMethod: Decodable {
  var type: String
  var id: Int
}
