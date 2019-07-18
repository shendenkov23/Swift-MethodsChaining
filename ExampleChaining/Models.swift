//
//  Models.swift
//  ExampleChaining
//
//  Created by  iDeveloper on 7/18/19.
//  Copyright © 2019  iDeveloper. All rights reserved.
//

import Foundation

struct User {
  let userId: String
  let email: String
  let firstname: String
  let latname: String
  let age: Int
}

struct ImportangThing {
  let thingId: String
  let thingSome: String
}

struct LoginParams {
  let login: String
  let pass: String
}
