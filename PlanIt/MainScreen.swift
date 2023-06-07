//
//  MainScreen.swift
//  PlanIt
//
//  Created by Bogdan Monid on 28.05.23.
//

import UIKit

class MainScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    
   var tasks = [ModelTask]()
    
    @IBOutlet weak var tableViewLabel: UITableView!
    
//    var tasks = ["go to store",
//                 "plan for the next day",
//                 "important facts"]

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "28313A")
      
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = tasks[indexPath.row].nameTask
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
        guard let notesVC = segue.destination as? UINavigationController else {return}
        (notesVC.topViewController as! NotesViewController).delegate = self
        
        present(notesVC, animated: true)
    }
}

extension MainScreen: NotesViewControllerDelegate{
    func completedCreateTask(data: ModelTask) {
        tasks.append(data)
        tableViewLabel.reloadData()
    }
}
