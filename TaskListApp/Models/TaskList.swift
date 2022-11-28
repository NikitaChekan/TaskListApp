//
//  TaskList.swift
//  TaskListApp
//
//  Created by Nikita Chekan on 28.11.2022.
//

import Foundation
import RealmSwift

class TaskList: Object { /// Унаследуем Object от фреймворка
    @Persisted var name = "" /// Дописываем Persisted тоже для фреймворка
    @Persisted var date = Date()
    @Persisted var tasks = List<Task>() ///Инициализация коллекции
}

class Task: Object {
    @Persisted var name = ""
    @Persisted var note = ""
    @Persisted var date = Date()
    @Persisted var isComplete = false
}
