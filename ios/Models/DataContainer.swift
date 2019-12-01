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

struct RequestPaymentRule: Codable {
  var paymentMethodId: Int
  var foundationId: Int
  var amount: String
}

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

struct ResponsePaymentRule: Codable {
  var paymentMethodId: Int
  var foundationId: Int
  var amount: Int
  var id: Int
}

struct Transaction: Codable {
  var id: Int
  var paymentRuleId: Int
  var transactionHash: String
  var createdAt: String
}

struct ResponsePaymentMethod: Codable {
  var type: String
  var address: String
  var id: Int
}

struct RequestPaymentMethod: Codable {
  var type: String
  var privateKey: String
}
