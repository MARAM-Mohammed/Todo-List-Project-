//
//  TodosdetailsVC.swift
//  To Do List project
//
//  Created by MARAM on 24/04/1443 AH.
//

import UIKit


class TodosdetailsVC: UIViewController {
    
    var todo :  Todo!
    var index: Int!
    
    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var todoTittleLabel: UILabel!
    @IBOutlet weak var todoDetailsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if todoImageView != nil{
            todoImageView.image = todo.image
        }else{
            todoImageView.image = UIImage(named: "Image")
        }
    
       
        setupUI()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(currebtTodoEdited), name: NSNotification.Name(rawValue: "CurrentTodoEdited"), object: nil)
        
    }
    
    
       @objc func currebtTodoEdited(notification: Notification)
    {
           if let todo = notification.userInfo?["editedTodo"] as? Todo
           {
               self.todo = todo
               setupUI()
               }
           }

    
//    DRY : Dont Repeat YourSelf .
    
    func setupUI(){
        todoTittleLabel.text = todo.title
        todoDetailsLabel.text = todo.details
        todoImageView.image = todo.image
    }

    @IBAction func editTodoButtonClicked(_ sender: Any) {
        
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "NewTodoVC") as? NewTodoVC {
             
            viewController.isCreation = false
            viewController.editedTodo = todo
            viewController.editedTodoIndex = index
            
            navigationController?.pushViewController(viewController , animated: true)
            viewController.isCreation = false
        }
    }
     


    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        let confirmAlert = UIAlertController(title: "تنبيه", message: "هل آنت متآكد ", preferredStyle: .alert)
        
        let confiremAction = UIAlertAction(title: "تآكيد", style: .destructive) { [self] alert in
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TodoDeleted"), object: nil, userInfo: ["deletedTodoIndex": index as Any])
        
        let alert = UIAlertController(title: "تم", message: "تم حذف المهمة بنجاح", preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "تم", style: .default)
        { alert in
            self.navigationController?.popViewController(animated: true)
        }
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)
        
    }
        confirmAlert.addAction(confiremAction)
        
        let cancelAction = UIAlertAction(title: "اغلاق", style: .default, handler: nil)
        confirmAlert.addAction(cancelAction)
        present(confirmAlert , animated: true, completion: nil)
    }
}



