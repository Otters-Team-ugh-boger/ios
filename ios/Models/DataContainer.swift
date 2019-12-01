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

struct PaymentRule: Codable {
  var paymentMethodId: Int
  var foundationId: Int
  var amount: Int
}

// MARK: - Response models
struct UserToken: Codable {
  var userId: Int
  var token: String
}

struct Foundation: Codable {
  var id: Int
  var name: String
  var description: String
  var paymentAddress: String
}

struct PaymentMethod: Codable {
  var type: String
  var id: Int
}
