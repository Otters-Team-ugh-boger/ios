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

struct UserToken: Codable {
  var token: String
}

struct PaymentMethods: Codable {
  var id: Int
  var type: String
}

struct Foundation: Decodable {
  var id: Int
  var name: String
  var description: String
  var paymentAdress: String
}
