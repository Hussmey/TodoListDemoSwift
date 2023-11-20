import SwiftUI

struct TodoListView: View {
    var username: String
    @State private var todoItems: [String] = []
    @State private var newItem: String = ""

    var body: some View {
        VStack {
            Text("Welcome, \(username)!")
                .font(.headline)
                .padding()

            TextField("Add a new todo item", text: $newItem)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add") {
                addTodoItem()
            }
            .buttonStyle(AddButtonStyle())
            .padding()

            List {
                ForEach(todoItems, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: deleteTodoItem)
            }
        }
        .padding()
        .onAppear {
                    todoItems = UserDefaults.standard.stringArray(forKey: "todoItems") ?? []
                }
    }

    private func addTodoItem() {
        guard !newItem.isEmpty else { return }
        todoItems.append(newItem)
        newItem = ""
        
                UserDefaults.standard.set(todoItems, forKey: "todoItems")
    }

    private func deleteTodoItem(at offsets: IndexSet) {
        todoItems.remove(atOffsets: offsets)
        UserDefaults.standard.set(todoItems, forKey: "todoItems")
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(username: "John")
    }
}

struct AddButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(configuration.isPressed ? Color.blue.opacity(0.8) : Color.blue)
            .cornerRadius(8)
    }
}
