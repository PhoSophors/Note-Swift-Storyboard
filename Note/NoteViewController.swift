//
//  NoteViewController.swift
//  Note
//
//  Created by Apple on 3/5/24.
//

import UIKit

struct Note {
    let title: String
    let detail: String
}

class NoteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notesData = [Note]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.allowsSelection = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveNote), name: NSNotification.Name.init("saveNote"), object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func saveNote(notification: Notification) {
        guard let note = notification.object as? Note else { return }
        notesData.append(note)
        tableView.insertRows(at: [IndexPath(item: notesData.count - 1, section: 0)], with: .automatic)
        tableView.reloadData()
    }
//
//    @objc func saveNote(notification: Notification) {
//      guard let note = notification.object as? Note else { return }
//      // Add the new note to the notesData array
//      notesData.append(note)
//    tableView.reloadData()
//      tableView.insertRows(at: [IndexPath(item: notesData.count - 1, section: 0)], with: .automatic)
// 
//    }
    
    @IBAction func addNoteAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    

    // MARK: - Navigation
     



}

extension NoteViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let notes = notesData[indexPath.item]
        
        noteCell.textLabel?.text = notes.title
        noteCell.textLabel?.text = notes.detail
        
        return noteCell
    }
}

extension NoteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self]_, _, complete in
            self?.notesData.remove(at: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
            complete(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            [weak self]_, _, complete in
//            self?.editNote.tableView(<#T##UITableView#>, canEditRowAt: <#T##IndexPath#>)
//            self?.editNote(at: indexPath.row)
            complete(true)
        }
        editAction.backgroundColor = .blue
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func editNote(at indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
