//
//  FoundationTableViewController.swift
//  ios
//
//  Created by vladislav on 30.11.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class FoundationTableViewController: UITableViewController {
  @IBOutlet var tableViewController: UITableView!
  
  let userDefaults = UserDefaults.standard
  var array = [Foundation]() {
    didSet {
      DispatchQueue.main.async {
        self.tableViewController.reloadData()
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    RequestManager.shared.getFoundation { completion in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          self.array = result
          self.userDefaults.set(result[0].id, forKey: "FoundationId")
        case .failure(let error):
          print(error)
        }
      }
    }
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "FoundationCell", for: indexPath)

    cell.textLabel?.text = array[indexPath.row].name

    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
    


}
