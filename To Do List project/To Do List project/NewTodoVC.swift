//
//  NewTodoVC.swift
//  To Do List project
//
//  Created by MARAM on 25/04/1443 AH.
//

import UIKit

class NewTodoVC: UIViewController {
    
    var isCreation = true
    var editedTodo : Todo?
    var editedTodoIndex: Int?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var todoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isCreation == false {
            mainButton.setTitle("تعديل", for: .normal)
            navigationItem.title = "تعديل مهمة"
            
            if let todo = editedTodo {
                titleTextField.text = todo.title
                detailsTextView.text = todo.details
                todoImageView.image = todo.image
            }
    }
}
    @IBAction func changeButtonClicked(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        if isCreation {
            let todo = Todo(title: titleTextField.text!, image: todoImageView.image, details: detailsTextView.text)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewTodoAdded"), object: nil , userInfo: ["addedTodo": todo])
            
            let alert = UIAlertController(title: "تمت الاضافة", message: "تمت اضافة المهمة بنجاح", preferredStyle: UIAlertController.Style.alert)
            
            let closeAction = UIAlertAction(title: "تم", style: UIAlertAction.Style.default) { [self]
                _ in
                self.tabBarController?.selectedIndex = 0
                self.titleTextField.text = ""
                self.detailsTextView.text = ""
            }
            alert.addAction(closeAction)
            present(alert, animated: true , completion: {
            })
        }else{
            let todo = Todo(title: titleTextField.text!, image: todoImageView.image , details: detailsTextView.text)
            NotificationCenter.default.post(name:NSNotification.Name(rawValue: "CurrentTodoEdited"), object: nil, userInfo: ["editedTodo": todo , "editedTodoIndex": editedTodoIndex])
            
            let alert = UIAlertController(title: "تم التعديل", message: "تم تعديل المهمة بنجاح", preferredStyle: UIAlertController.Style.alert)
            let closeAction = UIAlertAction(title: "تم", style: UIAlertAction.Style.cancel) { _ in
                
                self.navigationController?.popViewController(animated: true)
                self.titleTextField.text = ""
                self.detailsTextView.text = ""
            }
                alert.addAction(closeAction)
                present(alert, animated: true , completion: {
                    
                })
            }
        }
}


extension NewTodoVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any ]){
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        dismiss(animated: true , completion: nil)
        todoImageView.image = image
    }
}


