import Foundation

class ToDoPresenter: ObservableObject {
    private let repository = ToDoLocal()
    @Published var tasks: [ToDoTaskItem] = []
    
    init() {
        loadTasks()
    }
    
    func loadTasks() {
        tasks = repository.fetchTasks()
    }
    
    func addTask(title: String, description: String) {
        let newTask = ToDoTaskItem(title: title, description: description)
        tasks.append(newTask)
        repository.saveTasks(tasks)
    }
    
    func toggleTaskCompleted(id: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].isCompleted.toggle()
            repository.saveTasks(tasks)
        }
    }
    
    func deleteTask(id: UUID) {
        tasks.removeAll { $0.id == id }
        repository.saveTasks(tasks)
    }
    
    func updateTask(id: UUID, newTitle: String, newDescription: String) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].title = newTitle
            tasks[index].description = newDescription
            repository.saveTasks(tasks)
        }
    }
    func moveTask(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
        repository.saveTasks(tasks)
    }
    
    
}
