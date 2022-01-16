//
//  TodosVC.swift
//  To Do List project
//
//  Created by MARAM on 23/04/1443 AH.
//

import UIKit

class TodosVC: UIViewController {
  
    var todosArray = [
        Todo(title: "صنع القهوة" , image:UIImage(named: "coffee"), details: "شرب القهوة مع الحليب الساعة السابعة صباحا."),
        Todo(title: "قراءة كتاب", image:UIImage(named: "book"), details: "قراءة كتاب نظرية الفستق"),
        Todo(title: "مشاهدة البث", image:UIImage(named: "swift")),
        Todo(title: " ممارسة الرياضة", image:UIImage(named: "exercise"), details: "الساعة ٤ مساءا"),
        Todo(title: "الذهاب للسوق", image:UIImage(named: "mall")),
        Todo(title: "غسيل الملابس الشتوية", image:UIImage(named: "washing")),
        Todo(title: "طهي العشاء" , image:UIImage(named: "Egg") ,details: "بيض بالجبن")
    ]
             // 3- Creat Array and Struct

    @IBOutlet weak var todosTabelView: UITableView!
    // 1- Connection Tabel View OutLet
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(newTodoAdded), name: NSNotification.Name(rawValue: "NewTodoAdded"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(currebtTodoEdited), name: NSNotification.Name(rawValue: "CurrentTodoEdited"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(todoDeleted), name: NSNotification.Name(rawValue: "TodoDeleted"), object: nil)
        
        
        todosTabelView.dataSource = self
        // 2- if Download page load data is comming
        todosTabelView.delegate = self
    }
    @objc func newTodoAdded(notification: Notification){
        

        if let myTodo = notification.userInfo?["addedTodo"] as? Todo{
            todosArray.append(myTodo)
            todosTabelView.reloadData()
        }
    }
    
       @objc func currebtTodoEdited(notification: Notification){
           
           if let todo = notification.userInfo?["editedTodo"] as? Todo {
               
               if let index = notification.userInfo?["editedTodoIndex"] as? Int {
                   todosArray[index] = todo
                   todosTabelView.reloadData()
                   
               }
           }
            
        
}
    
       @objc func todoDeleted(notification: Notification){
           
               if let index = notification.userInfo?["deletedTodoIndex"] as? Int {
                   
                   todosArray.remove(at: index)
                   todosTabelView.reloadData()
               }
           }
            
       }


    extension TodosVC:UITableViewDataSource , UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoCell
        
        cell.todoTitleLabel.text = todosArray[indexPath.row].title
        
        if todosArray[indexPath.row].image != nil {
            cell.todosImageView.image = todosArray[indexPath.row].image
        }else{
            cell.todosImageView.image = UIImage(named: "Image")        }
        
        cell.todosImageView.layer.cornerRadius = cell.todosImageView.frame.width / 2
        
        return cell
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true) // clear square gray directly
            let todo = todosArray[indexPath.row]
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as? TodosdetailsVC
            
            if let viewController = vc {
                viewController.todo = todo
                viewController.index = indexPath.row
           
    navigationController?.pushViewController(viewController, animated: true)
                    
                
            }
        }
}
