import SwiftUI
//PREGUNTAR SI LOS STRINGS EN GENERAL, ES DECIR TANTO IMAGENES COMO  PLACEHOLDERS DEBERÍAN IR EN UN ARCHIVO DE CONSTANTES

struct TaskRow: View {
    let task: ToDoTaskItem
    let isEditing: Bool
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundColor(task.isCompleted ? .gray : .primary)
                }
                Spacer()
                Button(action: { isExpanded.toggle() }) {
                    Image(systemName: isExpanded ? AppStrings.Icons.chevronUp : AppStrings.Icons.chevronDown)
                        .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
                if !isEditing {
                    Image(systemName: task.isCompleted ? AppStrings.Icons.checkmarkCircleFill : AppStrings.Icons.circle)
                        .foregroundColor(task.isCompleted ? .green : .gray)
                        .font(.title2)
                }
                if isEditing {
                    Image(systemName: AppStrings.Icons.horizontalLines)
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                }
            }
            .padding()
            
            if isExpanded {
                HStack {
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing, .bottom])
                        .transition(.opacity)
                    Spacer()
                }
            }
        }
        .background(task.isCompleted ? Color.gray.opacity(0.2) : Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
        .animation(.easeInOut, value: isExpanded)
    }
}
