//
//  AddItemViewController.swift
//  GTD
//
//  Created by Daniel Pape on 06/06/2019.
//  Copyright © 2019 Daniel Pape. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [Items]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.returnKeyType = UIReturnKeyType.done

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapSaveButton(_ sender: UIButton) {
        
        let todoVC = self.navigationController?.viewControllers[0] as! TodoViewController
        let newItem = Items(context: self.context)
        newItem.name = textField.text!
        newItem.completed = false
        todoVC.items.append(newItem)
        
        print(todoVC.items)
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
