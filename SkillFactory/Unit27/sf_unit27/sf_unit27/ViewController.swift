//
//  ViewController.swift
//  sf_unit27
//
//  Created by Иван on 01.07.2023.
//

import UIKit
import CoreData
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
//    var arrayNotes:[String] = []
    var notes:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
        setNoteBtnToView()
        getFetchRequest()
        
        
        let realm = try! Realm()
        print(realm.configuration.fileURL)
        let film = MyRealmModel()
        
        do {
            try realm.write{
                realm.add(film)
            }
        } catch {
            print("KYKY \(error.localizedDescription)")
        }
        
    }
    private func setNoteBtnToView() {
        let createNewNoteBtn = UIButton()
        createNewNoteBtn.setBackgroundImage(UIImage(imageLiteralResourceName: "createNoteBtn"), for: .normal)
        view.addSubview(createNewNoteBtn)
        createNewNoteBtn.addTarget(self, action: #selector(handlerCreateNewNoteBtnPressed), for: .touchUpInside)
        createNewNoteBtn.translatesAutoresizingMaskIntoConstraints = false
        createNewNoteBtn.rightAnchor.constraint(equalTo: tableView.rightAnchor, constant: -40).isActive = true
        createNewNoteBtn.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -30).isActive = true
        createNewNoteBtn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        createNewNoteBtn.widthAnchor.constraint(equalToConstant: 70).isActive = true
      }

    @objc func handlerCreateNewNoteBtnPressed(){
        print("hello")
        let alert = UIAlertController(title: "Create note", message: "", preferredStyle: .alert)
        alert.addTextField{ textField in
            textField.placeholder = "Enter note..."
        }
        let cancel  = UIAlertAction(title: "cancel", style: .default)
        let create = UIAlertAction(title: "create", style: .cancel){ [unowned self] action in
            guard let textField = alert.textFields?.first, let noteSave = textField.text else { return }
            save(noteSave)
            tableView.reloadData()
        }
        alert.addAction(create)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func save (_ text: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(text, forKey: "noteName")
        try! managedContext.save ()
        notes.append(note)
    }
    
    func getFetchRequest(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        notes = try! managedContext.fetch(fetchRequest)
    }
    
    func edetNote(_ index: IndexPath){
        let alert = UIAlertController(title: "Edit note", message: "Change note", preferredStyle: .alert)
        let save = UIAlertAction(title: "save", style: .cancel){[unowned self] action in
            guard let textField = alert.textFields?.first, let noteSave = textField.text else { return }
            let oldText = self.notes[index.row].value(forKey: "noteName") as! String
            self.update(oldText, noteSave)
            
            tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "cancel", style: .default)
        alert.addTextField{ textField in
            textField.text = self.notes[index.row].value(forKey: "noteName") as? String
        }
        alert.addAction(save)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func update(_ oldText: String, _ newText: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "noteName = %@", oldText)
        let results = try! managedContext.fetch(fetchRequest) as? [NSManagedObject]
        if results?.count != 0{
            results![0].setValue(newText, forKey: "noteName")
        }
        try! managedContext.save()
    }
}

extension ViewController:UITableViewDelegate{
    
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].value(forKeyPath: "noteName") as? String
        cell.textLabel?.textColor = .brown
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.font = UIFont(name: "System", size: 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        edetNote(indexPath)
    }
    
}
