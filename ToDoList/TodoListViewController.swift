//
//  ViewController.swift
//  ToDoList
//
//  Created by Şeyda Soylu on 8.12.2022.
//

import UIKit

class TodoListViewController: UITableViewController {
    let userdefault = UserDefaults.standard
    var array = [item] ()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newitem = item()
        newitem.title = "Alınacaklar"
        newitem.done = true
        array.append(newitem)
    
        
        let newitem1 = item()
        newitem1.title = "Arabalar"
        array.append(newitem1)
        
        let newitem2 = item()
        newitem2.title = "Alışveriş listesi"
        array.append(newitem2)

 //       if let item = userdefault.array(forKey: "array") as? [String] {
 //           array = [item]
 //       }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        array[indexPath.row].done = !array[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        let item = array[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done  ? .checkmark : .none
        
        return cell
    }

    @IBAction func plusButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { [self] (action) in
            if textField.text != nil {
                
                let newitem = item()
                newitem.title = (textField.text)!
                array.append(newitem)
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

