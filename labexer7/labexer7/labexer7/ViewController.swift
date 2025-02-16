//
//  ViewController.swift
//  labexer7
//
//  Created by Elizabeth Thomas on 2025-02-15.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    
    var tableData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    @IBAction func generateTable(_ sender: UIButton) {
        guard let numString = numberTextField.text, let num = Int(numString) else { return }
        tableData = (1...10).map { "\($0) x \(num) = \($0 * num)"}
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    

    

}

