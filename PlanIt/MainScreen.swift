//
//  MainScreen.swift
//  PlanIt
//
//  Created by Bogdan Monid on 28.05.23.
//

import UIKit

class MainScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableViewLabel: UITableView!
    
    var model = [Model]()
    
//    var tasks = ["go to store",
//                 "plan for the next day",
//                 "important facts"]

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "28313A")
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = model[indexPath.row].text
        return cell
    }
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard let notesVC = segue.source as? NotesViewController else {return}
        notesVC.saveText()
        model.append(notesVC.model!)
        tableViewLabel.reloadData()
    }
    
   
    // MARK: - Navigation

   
   
}
