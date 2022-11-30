//
//  DataManager.swift
//  TaskListApp
//
//  Created by Nikita Chekan on 28.11.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData(completion: @escaping () -> Void) { /// Создание набора шаблонных данных при первой установке приложения

        let shoppingList = TaskList() /// Создаем  список задач (так рекомендуется создавать)
        shoppingList.name = "Shopping List"
        
        let moviesList = TaskList( /// Создаем  список задач и сразу добавляем в него напоминание (так не рекомендуется т.к. код не читабелен)
            value: [
                "Movies List", /// определяем заголовок
                Date(), /// определяем дату
                [ /// определяем коллекцию с задачами
                    ["Best film ever"],
                    ["The best of the best", "Must have", Date(), true] /// Определяем что эта задача была просмотренна
                ]
            ]
        )
        
        let milk = Task() /// Создаем задачу в коллекцию shoppingList
        milk.name = "Milk"
        milk.note = "2L"
        
        let bread = Task(value: ["Bread", "", Date(), true]) /// Создаем задачу в коллекцию shoppingList из модели TaskList с помощью массива
        let apples = Task(value: ["name": "Apples", "note": "2Kg"]) /// Создаем задачу  с помощью словаря
        
        shoppingList.tasks.append(milk) /// Добаляем задачу в коллекцию
        shoppingList.tasks.insert(contentsOf: [bread, apples], at: 1)
        
        DispatchQueue.main.async { /// Меняем поток с главного на параллельный
            StorageManager.shared.save([shoppingList, moviesList]) /// Добавляем эти данные в БД
            UserDefaults.standard.set(true, forKey: "done")
            completion() /// применяем для обновления интерфейса ReloadData
        }
    }
}
