//
//  StorageManager.swift
//  TaskListApp
//
//  Created by Nikita Chekan on 28.11.2022.
//

import Foundation
import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    let realm = try! Realm() /// Создаем точку входа в БД
    
    private init() {}
    
    // MARK: - Task List
    func save(_ taskLists: [TaskList]) { /// Метод для сохранения набитых вручную тестовых данных из DataManager
        write {
            realm.add(taskLists)
        }
    }
    
    func save(_ taskList: String, completion: (TaskList) -> Void) {
        write {
            let taskList = TaskList(value: [taskList])
            realm.add(taskList)
            completion(taskList)
        }
    }
    
    func delete(_ taskList: TaskList) {
        write {
            realm.delete(taskList.tasks) /// удаляем задачи сначала чтоб они не копились в базе
            realm.delete(taskList) /// удаляем сам список
        }
    }
    
    func edit(_ taskList: TaskList, newValue: String) {
        write {
            taskList.name = newValue
        }
    }

    func done(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
    }

    // MARK: - Tasks
    func save(_ task: String, withNote note: String, to taskList: TaskList, completion: (Task) -> Void) {
        write {
            let task = Task(value: [task, note])
            taskList.tasks.append(task)
            completion(task)
        }
    }
    
    private func write(completion: () -> Void) { /// Оборачиваем метод !try фреймворка чтобы было меньше кода
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
