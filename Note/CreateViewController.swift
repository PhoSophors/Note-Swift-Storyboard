//
//  CreateViewController.swift
//  Note
//
//  Created by Apple on 3/5/24.
//

import UIKit


protocol CreateNote {
    func saveData(note: Note)
    func updateData(note: Note)
}

class CreateViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var bottomContrain: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Note"
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeybord), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
//    @objc func showKeyboard(notification: Notification) {
//        let size = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//        bottomContrain.constant = size.height
//    }
    @objc func showKeyboard(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            bottomContrain.constant = keyboardSize.height
            view.layoutIfNeeded()
        }
    }
    
    @objc func hideKeybord(notificantion: Notification) {
        bottomContrain.constant = 0
        view.layoutIfNeeded()
    }

    @IBAction func saveBtnAction(_ sender: UIButton) {
        let title = titleTextField.text ?? " "
        let detail = descriptionTextField.text ?? " "
        let note = Note(title: title, detail: detail)
        NotificationCenter.default.post(name: NSNotification.Name.init("saveNote"), object: note)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - Navigation


}
