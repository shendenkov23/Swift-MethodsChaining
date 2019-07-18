//
//  ViewController.swift
//  ExampleChaining
//
//  Created by  iDeveloper on 7/18/19.
//  Copyright © 2019  iDeveloper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet private weak var btnAgain: UIButton!

  // MARK: -

  override func viewDidLoad() {
    super.viewDidLoad()

    startChain()
  }

  @IBAction private func btnAgainPresssed(_ sender: UIButton) {
    startChain()
  }

  // MARK: -

  private func startChain() {
    print("\n==== START CHAIN ====")
    btnAgain.isEnabled = false

    let chain =
      login ==>                           // - Login request
      {
        print("Get userId from user")
        $1(.success($0.userId))
      } ==>     // - working with the data received from the login request
                                          // and preparation for the next request
                                          // (optional step)
      getSomeImportant                    // - GetSomeImportant request

    // Without comments & print:
    // let chain = login ==> { $1(.success($0.userId)) } ==> getSomeImportant
    
    chain(LoginParams(login: "jhoraPobeditel", pass: "qwerty")) { [weak self] result in
      switch result {
      case .success(let thing):
        print("Chain success. Thing:", thing.thingId)
      case .failure:
        print("Chain failure. This is fake failure, so try again! :]")
      }
      DispatchQueue.main.async {
        self?.btnAgain.isEnabled = true
      }
    }
  }

  private func login(input: LoginParams,
                     completion: @escaping ChainOperationCompletion<ChainOperationResult<User>>) {
    print("Start login request")
    fakeRequest { result in
      switch result {
      case .success:
        let user = User(userId: UUID().uuidString,
                        email: "\(input.login)@gmail.com",
                        firstname: "\(input.login)FirstName",
                        latname: "\(input.login)LastName",
                        age: Int.random(in: 20...30))
        print("Login success!")
        completion(.success(user))
      case .failure(let error):
        print("Login failure!")
        completion(.failure(error))
      }
    }
  }

  private func getSomeImportant(for userId: String,
                                completion: @escaping ChainOperationCompletion<ChainOperationResult<ImportangThing>>) {
    print("Start GetSomeImportant request")
    fakeRequest { result in
      switch result {
      case .success:
        print("GetSomeImportant success!")
        let thing = ImportangThing(thingId: "\(userId)-\(UUID().uuidString)",
                                   thingSome: "\(userId)-\(UUID().uuidString)")
        completion(.success(thing))
      case .failure(let error):
        print("GetSomeImportant failure!")
        completion(.failure(error))
      }
    }
  }

  private func fakeRequest(completion: @escaping (Result<Void, NSError>) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
      let isFailure = arc4random() % 4 == 0 // one of four
      if isFailure {
        let error = NSError(domain: "com.chaining", code: 999, userInfo: nil)
        completion(.failure(error))
      } else {
        completion(.success(Void()))
      }
    }
  }
}
