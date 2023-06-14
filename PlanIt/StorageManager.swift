//
//  StorageManager.swift
//  PlanIt
//
//  Created by Bogdan Monid on 10.06.23.
//

import Foundation


class StorageManager{
    
    static let taskKey: String = "taskKey"   // ключ
    
    static func getTasks() -> [ModelTask]{
        
        if let data = UserDefaults.standard.value(forKey: taskKey) as? Data,
           let tasks = try? JSONDecoder().decode([ModelTask].self, from: data){
            return tasks
        } else {
            let tasks = [ModelTask]()
            
            return tasks
        }
    }
    
    
    static func saveTask(task: ModelTask) { // создаем метод для сохранения записей
        //if - когда есть данные по этому ключу
        var tasks = getTasks()
        
        tasks.append(task)
        UserDefaults.standard.setValue( try? JSONEncoder().encode(tasks), forKey: taskKey)  //кодируем данные и сохраняем их
        
    }
    
    
//
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
//
     
    
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
