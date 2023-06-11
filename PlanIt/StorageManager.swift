//
//  StorageManager.swift
//  PlanIt
//
//  Created by Bogdan Monid on 10.06.23.
//

import Foundation


class StorageManager{
    
    static let taskKey: String = "taskKey"   // ключ
    
    static func saveTask(task: ModelTask) { // создаем метод для сохранения записей
        
        if let data = UserDefaults.standard.value(forKey: taskKey) as? Data,   // проверяем, если есть данные по такому то ключу, а так же, если есть массив для этих данных то
           var tasks = try? JSONDecoder().decode([ModelTask].self, from: data){
            
            tasks.append(task)   //  добавляем задачу в массив
            
            guard let encodedData = encodedTask(tasks: tasks) else {return} // проверяем, что данные, которые мы хотим сохранить не пустые
            
            UserDefaults.standard.setValue(encodedData, forKey: taskKey) // сохраняем данные
        } else {     // если же пусто, то
            var tasks = [ModelTask]()   // создаем массив
            tasks.append(task)    // добавляем задачу
            UserDefaults.standard.setValue(encodedTask(tasks: tasks), forKey: taskKey)  // сохраняем их
        }
    }
    
    static func getTasks() -> [ModelTask]{   // тут получаем данные / задачи
        
        guard let data = UserDefaults.standard.value(forKey: taskKey) as? Data,
              let tasks = try? JSONDecoder().decode([ModelTask].self, from: data) else {return []}
        
        return tasks
    }
    
   static func encodedTask(tasks: [ModelTask]) -> Data?{  // здесь проверяем, если есть данные для сохранения, и если они есть, то сохраняем их. так же метод преобразует массив                                                                                                                            задач в формат, который можно сохранить
        return try? JSONEncoder().encode(tasks)
    }
}
