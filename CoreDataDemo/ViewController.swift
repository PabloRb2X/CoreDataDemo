//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Pablo Ramirez on 19/12/17.
//  Copyright © 2017 Pablo Ramirez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //// Se cargan los datos almacenados previamente
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        do{
            let people = try DatabaseController.context.fetch(fetchRequest)
            self.people = people
            self.tableView.reloadData()
        }catch let error{
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPlusTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField{ (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField{ (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        
        let action = UIAlertAction(title: "Post", style: .default) { (_) in
            let name = alert.textFields!.first!.text!
            let age = alert.textFields!.last!.text!
            print(name)
            print(age)
            let person = Person(context: DatabaseController.context)
            person.name = name
            person.age = Int16(age)!
            DatabaseController.saveContext()
            self.people.append(person)
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //// Ocultar la barra de estado (no mostrar la hora, compañía, etc)
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
}

extension  ViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = String(people[indexPath.row].age)
        
        return cell
    }
}

