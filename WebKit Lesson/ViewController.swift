//
//  ViewController.swift
//  WebKit Lesson
//
//  Created by Denis Bystruev on 08.04.2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UITableViewController {
    
    struct Petitions: Codable {
        struct Metadata: Codable {
            struct ResponseInfo: Codable {
                let status: Int
            }
            let responseInfo: ResponseInfo
        }
        let metadata: Metadata
        let results: [Result]
    }
    
    struct Result: Codable {
        let title: String
        let body: String
    }
    
    var petitions = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.whitehouse.gov/v1/petitions.json?limit=100")!
        
        if let json = try? String(contentsOf: url) {
            let inputData = json.data(using: .utf8)!
            let decoder = JSONDecoder()
            if let petitionList = try? decoder.decode(Petitions.self, from: inputData) {
                if 200...299 ~= petitionList.metadata.responseInfo.status {
                    petitions = petitionList.results
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1). \(petitions[indexPath.row].title)"
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
}
