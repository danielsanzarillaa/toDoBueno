import SwiftUI
//Preguntar si en la parte de LIST  deberia meterlo dentro de algun metodo o algo para
//que se vea mas bonito


struct ToDoView: View {
    @StateObject private var presenter = ToDoPresenter()
    @State private var newTaskTitle = ""
    @State private var newTaskDescription = ""
    @State private var editMode = EditMode.inactive
    @State private var taskToEdit: ToDoTaskItem?
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 15) {
                    TextField(AppStrings.Task.taskTitle, text: $newTaskTitle)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    TextField(AppStrings.Task.optionalDescription, text: $newTaskDescription)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    Button(action: addTask) {
                        HStack {
                            Image(systemName: AppStrings.Icons.plusCircleFill)
                            Text(AppStrings.Task.addTask)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(16)
                        .padding(.top)
                        .padding(.bottom)
                    }
                    .disabled(newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.top)
                .padding(.horizontal, 25)
                List {
                    ForEach(presenter.tasks) { task in
                        TaskRow(task: task, isEditing: editMode == .active)
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                if editMode == .active {
                                    taskToEdit = task
                                } else {
                                    presenter.toggleTaskCompleted(id: task.id)
                                }
                            }
                    }
                    .onDelete(perform: deleteTask)
                    .onMove(perform: presenter.moveTask)
                    
                }.environment(\.editMode, .constant(.inactive))
                    .listStyle(PlainListStyle())
                    .padding(.horizontal, 25)
            }
            .navigationTitle(AppStrings.Task.myTasks)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { editMode = editMode == .active ? .inactive : .active }) {
                        Text(editMode == .active ? AppStrings.Task.done : AppStrings.Task.edit)
                    }
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(item: $taskToEdit) { task in
                EditTaskView(task: task, presenter: presenter)
            }
        }
    }
    
    private func addTask() {
        presenter.addTask(title: newTaskTitle, description: newTaskDescription)
        newTaskTitle = ""
        newTaskDescription = ""
    }
    
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            presenter.deleteTask(id: presenter.tasks[index].id)
        }
    }
    
    
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
