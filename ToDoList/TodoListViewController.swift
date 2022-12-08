//
//  ViewController.swift
//  ToDoList
//
//  Created by Şeyda Soylu on 8.12.2022.
//

import UIKit

class TodoListViewController: UITableViewController {
    let userdefault = UserDefaults.standard
    var array = ["Alınacaklar", "Arabalar", "Alışveriş listesi"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = userdefault.array(forKey: "array") as? [String] {
            array = item
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
            if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
        
        
    }
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.4) {
            if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                tableView.cellForRow(at: indexPath)?.backgroundColor = .white
            } else {
                tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(red: 34/255, green: 139/255, blue: 34/255, alpha: 0.8)
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }

    @IBAction func plusButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { [self] (action) in
            if textField.text != nil {
                array.append(textField.text!)
                tableView.reloadData()
                self.userdefault.set(self.array, forKey: "array")
            }
        }
        alert.addAction(action)
        alert.addTextField {(alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        present(alert, animated: true , completion: nil)
        
    }
    
}

