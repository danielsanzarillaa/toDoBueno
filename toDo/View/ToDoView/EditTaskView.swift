import SwiftUI

struct EditTaskView: View {
    @State private var title: String
    @State private var description: String
    @Environment(\.presentationMode) private var presentationMode
    let task: ToDoTaskItem
    let presenter: ToDoPresenter
    
    init(task: ToDoTaskItem, presenter: ToDoPresenter) {
        self.task = task
        self.presenter = presenter
        _title = State(initialValue: task.title)
        _description = State(initialValue: task.description)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(AppStrings.Task.title)) {
                    TextField(AppStrings.Task.taskTitle, text: $title)
                        .disableAutocorrection(true)
                }
                Section(header: Text(AppStrings.Task.description)) {
                    TextField(AppStrings.Task.taskDescription, text: $description)
                        .disableAutocorrection(true)
                }
            }
            .navigationTitle(AppStrings.Task.editTask)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(AppStrings.Task.cancel) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(AppStrings.Task.save) {
                        presenter.updateTask(id: task.id, newTitle: title, newDescription: description)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
