//
//  ViewController.swift
//  GTD
//
//  Created by Daniel Pape on 05/06/2019.
//  Copyright © 2019 Daniel Pape. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UITableViewController {
    
    var items = [Items]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Table View Datasource Methods:
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.accessoryType = item.completed ? .checkmark : .none
        return cell
    }
    
    //MARK: Table View Delegate Methods:
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none )
        items[indexPath.row].completed = !items[indexPath.row].completed
        
        saveItems()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let item = items[indexPath.row]
            items.remove(at: indexPath.row)
            context.delete(item)
            
            do{
                try context.save()
            }catch {
                print("Error deleting item with /(error)")
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Save", style: .default) {(action) in
            
            let newItem = Items(context: self.context)
            newItem.name = textField.text!
            newItem.completed = false
            self.items.append(newItem)
            self.saveItems()
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new todo item"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        
        do {
            try context.save()
        }catch {
            print("Error saving item with \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        
        do {
        items = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
}

