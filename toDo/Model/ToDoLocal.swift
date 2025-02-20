
import Foundation

struct ToDoTaskItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var description: String
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false,description: String="") {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.description = description
    }
}

class ToDoLocal {
    private let userKey = "toDoTasks"
    
    //Hago este init para que si le pasamos ese parámetro por el UITest borre todo y asi cada UITest empieza con bd a 0
    init() {
        if CommandLine.arguments.contains("--resetUserDefaults") {
            UserDefaults.standard.removeObject(forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func fetchTasks() -> [ToDoTaskItem] {
        guard let data = UserDefaults.standard.data(forKey: userKey) else { return [] }
        do {
            let tasks = try JSONDecoder().decode([ToDoTaskItem].self, from: data)
            return tasks
        } catch {
            print("Error al decodificar las tareas: \(error)")
            return []
        }
    }
    
    func saveTasks(_ tasks: [ToDoTaskItem]) {
        let data = try? JSONEncoder().encode(tasks)
        UserDefaults.standard.set(data, forKey: userKey)
    }
}

