//
//  StorageManager.swift
//  PlanIt
//
//  Created by Bogdan Monid on 10.06.23.
//

import Foundation


class StorageManager{
    
    private let taskKey: String = "taskKey"   // ключ
    private let coffeeCupKey: String = "coffeeCupKey"
    private let checkMarkKey: String = "checkMarkKey"
    private let userDefaults = UserDefaults.standard
    static let shared = StorageManager()
//    var isSelected: Bool{
//        get{
//            return userDefaults.bool(forKey: chekMarkKey)
//        }
//        set{
//            userDefaults.set(newValue, forKey: chekMarkKey)
//            userDefaults.synchronize()
//        }
//    }
    
    static func getTasks() -> [ModelTask]{
        
        if let data = UserDefaults.standard.value(forKey: shared.taskKey) as? Data,
           let tasks = try? JSONDecoder().decode([ModelTask].self, from: data){
            return tasks
        } else {
            let tasks = [ModelTask]()
            
            return tasks
        }
    }
    
    static func saveTask(task: ModelTask) { // создаем метод для сохранения записей
        
        var tasks = getTasks()
        
        tasks.append(task)
        UserDefaults.standard.setValue( try? JSONEncoder().encode(tasks), forKey: shared.taskKey)  //кодируем данные и сохраняем их
    }
    
    static func getTask(title: String) -> ModelTask?{ //находим нужную задачу
        
        let tasks = getTasks() // получаем задачи
        
        let findTask = tasks.first { $0.titleTask == title } // получаем нужную задачу по заголовку. Функция first перебирает массив, пока не найдет true в условии

        return findTask // опционалная, т.к объекта может и не быть и вернется nil
    }
    
    static func replaceTask(task: ModelTask){   // принимаем и подменяем задачу
        
        var tasks = getTasks()
        
        let findTask = tasks.first { $0.id == task.id} // так же находим задачу, только параметр пойска уже id
        let taskIndex = tasks.firstIndex(where: { $0.id == task.id }) // получаем индекс задачи, которую отредактировали
        tasks[taskIndex!].titleTask = task.titleTask  // перезаписываем задачу. [taskIndex!] ведет к задаче, которую отредактировали. заменяем старые данные на новые
        tasks[taskIndex!].descriptionTask = task.descriptionTask
        UserDefaults.standard.setValue(try? JSONEncoder().encode(tasks), forKey: shared.taskKey) //кодируем данные и сохраняем
    }
    
    static func saveCup(_ cup: Int){
        UserDefaults.standard.set(cup, forKey: shared.coffeeCupKey)
    }
    
    static func loadCup() -> Int?{
        UserDefaults.standard.value(forKey: shared.coffeeCupKey) as? Int 
    }
//    
//    static func saveCheckMark(isEdit: Bool, forRow row: Int){
//        UserDefaults.standard.set(isEdit, forKey: shared.checkMarkKey)
//    }
//
//    static func loadCheckMark(forRow row: Int) -> Bool{
//       return UserDefaults.standard.bool(forKey: shared.checkMarkKey)
//    }
    
    
    
    //    static func saveTask(task: ModelTask) { // создаем метод для сохранения записей
    //        //if - когда есть данные по этому ключу
    //        var tasks = getTasks()
    //        if tasks.count > 0{
    //
    //            tasks.append(task)   //  добавляем задачу в массив
    //
    //            guard let encodedData = try? JSONEncoder().encode(tasks) else {return}
    //
    //            UserDefaults.standard.setValue(encodedData, forKey: taskKey) // сохраняем данные
    //            //else - когда нет данных по этому ключу
    //
    //        } else {     // если же пусто, то
    //            tasks.append(task)    // добавляем задачу
    //            UserDefaults.standard.setValue( try? JSONEncoder().encode(tasks), forKey: taskKey)  //кодируем данные и сохраняем их
    //        }
    //    }
    
    //    static func saveTask(task: ModelTask) { // создаем метод для сохранения записей
    //        //if - когда есть данные по этому ключу
    //        if let data = UserDefaults.standard.value(forKey: taskKey) as? Data,   // проверяем, если есть данные по такому то ключу, а так же, если есть массив для этих данных то
    //           // приводим к типу Data, иначе data будет типа Any
    //            var tasks = try? JSONDecoder().decode([ModelTask].self, from: data){
    //
    //            tasks.append(task)   //  добавляем задачу в массив
    //
    //            guard let encodedData = try? JSONEncoder().encode(tasks) else {return}
    //
    //            UserDefaults.standard.setValue(encodedData, forKey: taskKey) // сохраняем данные
    //            //else - когда нет данных по этому ключу
    //
    //        } else {     // если же пусто, то
    //
    //            var tasks: [ModelTask] = []   // создаем массив
    //            tasks.append(task)    // добавляем задачу
    //            UserDefaults.standard.setValue( try? JSONEncoder().encode(tasks), forKey: taskKey)  //кодируем данные и сохраняем их
    //        }
    //    }
}

//encode кодирование
//decode декодирование/ расшифрование


//Эта функция encodedTask() принимает массив объектов типа ModelTask и возвращает данные (Data), которые были                                                                                                                                  закодированы из этого массива в формат JSON.
// Для этого мы используем класс JSONEncoder() и его метод encode(), чтобы преобразовать массив tasks в формат JSON. Если кодирование проходит успешно, функция возвращает данные в формате Data.
// Если происходит ошибка при кодировании, функция возвращает nil.
