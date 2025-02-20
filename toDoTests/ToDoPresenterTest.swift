import XCTest
@testable import toDo

class ToDoPresenterTests: XCTestCase {
    
    var presenter: ToDoPresenter!
    
    override func setUp() {
        UserDefaults.standard.removeObject(forKey: "toDoTasks")
        presenter = ToDoPresenter()
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "toDoTasks")
        presenter = nil
    }
    
    func testLoadTasks_WhenNoTasksSaved_ShouldReturnEmptyList() {
        presenter.loadTasks()
        XCTAssertTrue(presenter.tasks.isEmpty)
    }
    
    func testAddTask_ShouldIncreaseTheTasks() {
        presenter.addTask(title: "Nueva tarea", description: "Descripción de prueba")
        XCTAssertEqual(presenter.tasks.count, 1)
        XCTAssertEqual(presenter.tasks.first?.title, "Nueva tarea")
        XCTAssertEqual(presenter.tasks.first?.description, "Descripción de prueba")
    }
    
    func testToggleTaskCompleted_ShouldChangeTaskState() {
        presenter.addTask(title: "Tarea test", description: "")
        let taskID = presenter.tasks.first!.id
        presenter.toggleTaskCompleted(id: taskID)
        XCTAssertTrue(presenter.tasks.first!.isCompleted)
        presenter.toggleTaskCompleted(id: taskID)
        XCTAssertFalse(presenter.tasks.first!.isCompleted)
    }
    
    func testDeleteTask_ShouldRemoveTaskFromList() {
        presenter.addTask(title: "Tarea a eliminar", description: "")
        let taskID = presenter.tasks.first!.id
        presenter.deleteTask(id: taskID)
        XCTAssertTrue(presenter.tasks.isEmpty)
    }
    
    func testUpdateTask_ShouldModifyTaskDetails() {
        presenter.addTask(title: "Tarea inicial", description: "Descripción inicial")
        let taskID = presenter.tasks.first!.id
        presenter.updateTask(id: taskID, newTitle: "Tarea editada", newDescription: "Descripción Editada")
        XCTAssertEqual(presenter.tasks.first!.title, "Tarea editada")
        XCTAssertEqual(presenter.tasks.first!.description, "Descripción Editada")
    }
    
    func testMoveTask_ShouldReorderTasks() {
        presenter.addTask(title: "Primera", description: "")
        presenter.addTask(title: "Segunda", description: "")
        presenter.addTask(title: "Tercera", description: "")
        presenter.moveTask(from: IndexSet(integer: 2), to: 0)
        XCTAssertEqual(presenter.tasks.first!.title, "Tercera")
        XCTAssertEqual(presenter.tasks[1].title, "Primera")
        XCTAssertEqual(presenter.tasks[2].title, "Segunda")
    }
}
