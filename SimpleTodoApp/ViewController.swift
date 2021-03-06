//
//  ViewController.swift
//  SimpleTodoApp
//
//  Created by Stefan Milenkovic on 3/22/19.
//  Copyright © 2019 Stefan Milenkovic. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var todos = [Todo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        
        
        loadTodos()
        
    }
    
    
    @objc func addTodo() {
        
        
        let ac = UIAlertController(title: "Add todo", message: "Enter todo you want to add.", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add todo", style: .default){ [weak self, weak ac]_ in
            
            guard let text = ac?.textFields?[0].text else {return}
           
            let newTodo = Todo(title: text, completed: false)
            self?.todos.append(newTodo)
            
            let jsonEncoder = JSONEncoder()
            if let savedData = try? jsonEncoder.encode(self?.todos) {
                let defaults = UserDefaults.standard
                
                defaults.set(savedData, forKey: "todo")
                print("Sacuvano")
            }
            
            
            self?.tableView.reloadData()
            
            
            
            
        })
        
        present(ac, animated: true, completion: nil)
        
        
        
    }
    
    
    func editToDo(todo: Todo) {
        
        if todo.completed == false {
            todo.completed = true
        }else if todo.completed == true {
            todo.completed = false
        }
        
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(todos){
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "todo")
        }
        
        tableView.reloadData()
    }
    
    
   
    

    
    func loadTodos() {
        let defaults = UserDefaults.standard
        
        if let savedData = defaults.object(forKey: "todo") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do{
                
                todos = try jsonDecoder.decode([Todo].self, from: savedData)
                tableView.reloadData()
                
            }catch {
                print("Error loading data")
            }
        }
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedTodo = todos[indexPath.row]
        
        editToDo(todo: selectedTodo)
        
    }
   
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath )
        
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        
        if todo.completed {
            cell.accessoryType = .checkmark
        }else if !todo.completed {
            cell.accessoryType = .none
        }
       
        
        return cell
    }
    


}

