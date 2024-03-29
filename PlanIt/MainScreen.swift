//
//  MainScreen.swift
//  PlanIt
//
//  Created by Bogdan Monid on 28.05.23.
//

import UIKit


class MainScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let coffeeVC = CoffeeViewController()
    var tasks = StorageManager.getTasks()
    var selectedIndex = -1
    var isCollapce = false
    var key: String = "key"
    private var editTask: ModelTask?
   
    @IBOutlet weak var tableViewLabel: UITableView!
    @IBOutlet weak var coffeeButton: UIButton!
    @IBOutlet weak var haveANiceDay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor(named: "28313A")
        
        coffeeButton.addTarget(self, action: #selector(presentCoffeeControl), for: .touchUpInside)
        
        tableViewLabel.separatorInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        tableViewLabel.estimatedRowHeight = 200
        tableViewLabel.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func checkMarkAction(_ sender: UIButton) {
        tasks[sender.tag].isDone.toggle()
        if tasks[sender.tag].isDone{
            sender.setImage(UIImage(named: "checkMark"), for: .normal)
        }else{
            sender.setImage(UIImage(named: "buttonImage"), for: .normal)
        }
        StorageManager.updateAlreadySavedTask(task: tasks[sender.tag])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedIndex == indexPath.row && isCollapce == true{
            return 200
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.titleLabel.text = tasks[indexPath.row].titleTask
        cell.descriptionTextViewLabel.text = tasks[indexPath.row].descriptionTask
        cell.checkMarkLabel.tag = indexPath.row
        cell.checkMarkLabel.setImage(UIImage(named: tasks[indexPath.row].isDone ? "checkMark" : "buttonImage" ), for: .normal)
        cell.customDelegate = self
        cell.selectionStyle = .none
        cell.animate()
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)         //Этот код используется для снятия выделения с ячейки таблицы.
        if selectedIndex == indexPath.row{
            if self.isCollapce == false{
                self.isCollapce = true
            }else{
                self.isCollapce = false
            }
        }else{
                self.isCollapce = true
            }
            self.selectedIndex = indexPath.row
            tableView.reloadRows(at: [indexPath], with: .automatic) //Этот метод используется для перезагрузки определенной строки таблицы с анимацией.
        }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            let removeTask = tasks.remove(at: indexPath.row)
            StorageManager.removeTask(task: removeTask)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {    // тут происхолит вызов при добавлении новой задачи
        guard let navigationNote = segue.destination as? UINavigationController else {return}
        (navigationNote.topViewController as? NotesViewController)?.delegate = self
        (navigationNote.topViewController as? NotesViewController)?.isEdit = false
        present(navigationNote, animated: true)
    }
}

extension MainScreen: NotesViewControllerDelegate{
    func completedCreateTask(data: ModelTask, isEdit: Bool) {
        if isEdit {    // если true, то редактируем задачу
            if let index = tasks.firstIndex(where: { $0.id == data.id }){
                tasks[index] = data
                StorageManager.updateAlreadySavedTask(task: data)
            }
        } else {   // если false, то добавляем новую задачу
            tasks.insert(data, at: 0)
          
            save(data: data)
        }
        tableViewLabel.reloadData()
    }
    
    func save(data: ModelTask){
        DispatchQueue.global().async {
            StorageManager.saveTask(task: data)
        }
    }
}

extension MainScreen: CustomTableViewCellDelegate{ // тут происходит редактирование задачи
    func editingTask(title: String) {
        let navigationNoteVC = storyboard?.instantiateViewController(withIdentifier: "storyboardIdentifier") as! UINavigationController
        (navigationNoteVC.topViewController as? NotesViewController)?.delegate = self
        (navigationNoteVC.topViewController as? NotesViewController)?.isEdit = true
        (navigationNoteVC.topViewController as? NotesViewController)?.editTask = StorageManager.getTask(title: title)
        
        present(navigationNoteVC, animated: true)
    }
}

extension MainScreen: CoffeeViewControllerDelegate{
    
    @objc func presentCoffeeControl(){
        let detailCoffeeVC = CoffeeViewController()
        detailCoffeeVC.delegate = self
        
        detailCoffeeVC.isModalInPresentation = true
       
        detailCoffeeVC.modalPresentationStyle = .automatic
        detailCoffeeVC.modalTransitionStyle = .crossDissolve
                                                  
        detailCoffeeVC.preferredContentSize = CGSize(width: 0, height: 300)
        detailCoffeeVC.sheetPresentationController?.detents = [.custom(resolver: { _ in
            return 570
        }),
            .custom(resolver: { context in
            context.maximumDetentValue * 2
            })
        ]
        detailCoffeeVC.sheetPresentationController?.prefersGrabberVisible = false
        present(detailCoffeeVC, animated: true)
        haveANiceDay.isHidden = false
        
    }
    
    @objc func cancelButton(){
        dismiss(animated: true)
    }
    
    func hideLabel() {
        haveANiceDay.isHidden = true
    }
    
    func showLabel() {
        haveANiceDay.isHidden = false
    }
}

