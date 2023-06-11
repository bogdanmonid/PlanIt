//
//  MainScreen.swift
//  PlanIt
//
//  Created by Bogdan Monid on 28.05.23.
//

import UIKit

class MainScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var tasks = StorageManager.getTasks()
    
    @IBOutlet weak var tableViewLabel: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "28313A")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = tasks[indexPath.row].titleTask
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationNote = segue.destination as? UINavigationController else {return}
       (navigationNote.topViewController as! NotesViewController).delegate = self
        
        present(navigationNote, animated: true)
    }
}

extension MainScreen: NotesViewControllerDelegate{
    func completedCreateTask(data: ModelTask) {
        tasks.append(data)
        
        save(data: data)
        
        tableViewLabel.reloadData()
    }
    
    func save(data: ModelTask){
        
        DispatchQueue.main.async {
            StorageManager.saveTask(task: data)
        }
    }
}
