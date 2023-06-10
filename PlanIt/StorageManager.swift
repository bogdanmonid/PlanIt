//
//  StorageManager.swift
//  PlanIt
//
//  Created by Bogdan Monid on 10.06.23.
//

import Foundation


class StorageManager{
    
    static let taskKey: String = "taskKey"   // ключ
    
    static func saveTask(task: ModelTask) {
        
        if let data = UserDefaults.standard.value(forKey: taskKey) as? Data,
           var tasks = try? JSONDecoder().decode([ModelTask].self, from: data){
            
            tasks.append(task)
            
            guard let encodedData = encodedTask(tasks: tasks) else {return}
            
            UserDefaults.standard.setValue(encodedData, forKey: taskKey)
        } else {
            var tasks = [ModelTask]()
            tasks.append(task)
            UserDefaults.standard.setValue(encodedTask(tasks: tasks), forKey: taskKey)
        }
    }
    
    static func getTasks() -> [ModelTask]{
        
        guard let data = UserDefaults.standard.value(forKey: taskKey) as? Data,
              var tasks = try? JSONDecoder().decode([ModelTask].self, from: data) else {return []}
        
        return tasks
    }
    
   static func encodedTask(tasks: [ModelTask]) -> Data?{
    
        return try? JSONEncoder().encode(tasks)
    }
}
