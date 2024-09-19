# Week 4 Tutorial: TaskManager App with SwiftUI

> [!NOTE]
>
> You're currently viewing the code just after step 10. For the code after step 7, go to the [solution-step7 branch](https://github.com/cis1951/lec4-code/tree/solution-step7).

## Introduction

We will do a simple demonstration of SwiftUI's capabilities for state management, including the use
of `@State`, `@Binding`, `@ObservedObject`, and `@EnvironmentObject`, using a TODO list app. This app allows users to
add tasks, mark them as completed, edit task details, and includes animations when reacting to state changes.

You can name it however you want; pick a fun name! For now, we'll call it "TaskManager."

Let's get started!

## Step 1: Set Up the Project

1. **Create a New SwiftUI Project**: Open Xcode, select "Create a new Xcode project," choose the SwiftUI App template,
   and name your project "TaskManager."
2. **Project Structure Overview**:
    - The `ContentView.swift` file is where we'll spend most of our time, crafting the UI and logic of our app.
    - The `@main` App struct in `TaskManagerApp.swift`, which serves as the entry point of our SwiftUI application.

## Step 2: Design the TodoItem Model

Create a `TodoItem.swift` file, define a `TodoItem` struct with the following properties:

```swift
import Foundation

struct TodoItem: Identifiable {
    var id = UUID()
    var name: String
    var isCompleted: Bool
}
```

(You can also add other properties as you see fit.)

## Step 3: Add a Task List to ContentView

In this step, we'll create a view that lists all the tasks. We'll use `@State` to manage the array of tasks within this
view.

Modify the `ContentView` to include a `@State` variable that holds an array of `TodoItem`s and display them in a `List`.

 ```swift
import SwiftUI

struct ContentView: View {
    @State private var todos = [TodoItem]()

    var body: some View {
        List(todos) { todo in
            Text(todo.name)
        }
    }
}

#Preview {
    ContentView()
}
 ```

## Step 4: Build a Form for User Input

Now, we'll add functionality to allow users to add new tasks to the list. We'll use a `TextField` for input and
a `Button` to submit the new task. This is a common combination that creates something similar to an HTML form for user
input.

Embed the existing `List` in a `VStack` and add a `TextField` and a `Button` above it to allow users to enter a new task
name and add it to the list.

```swift
struct ContentView: View {
    @State private var todos = [TodoItem]()
    @State private var newTodoName = "" // For handling user input
    
    var body: some View {
        VStack {
            TextField("Enter new todo", text: $newTodoName)
                .padding()
            
            Button(action: addNewTodo) {
                Text("Add Todo")
            }
            .padding()
            .disabled(newTodoName.isEmpty)
            
            List(todos) { todo in
                Text(todo.name)
            }
        }
    }
}
```

Your code may not compile at this point - this is fine. We'll fix that in the next step.

## Step 5: Create a New Task

Next, we implement the button functionality to add a new task upon form submission.

```swift
struct ContentView: View {
    // ...

    private func addNewTodo() {
        let newTodo = TodoItem(name: newTodoName, isCompleted: false)
        todos.append(newTodo)
        newTodoName = "" // Reset input field
    }

    // ...
}
```

## Step 6: Create a Custom View for Task Items

It is common to create a custom view for individual item views in a list, especially when the item view is complex. To
share data between the parent list and the children item views, we can use `@Binding`.

First, create a `TodoItemView.swift` file, and implement the item view with a button that toggles whether the todo is completed:

 ```swift
import SwiftUI

struct TodoItemView: View {
    @Binding var todo: TodoItem

    var body: some View {
        Text(todo.name)
    }
}
```

Then, update the `List` in `ContentView` to use the custom item view and pass in a binding:

```swift
List($todos) { $todo in
    TodoItemView(todo: $todo)
}
```

We are using a binding here because we are going to later modify `TodoItemView` so that it updates the todo item. Since it needs to update the item, we need to pass in a binding.

## Step 7: Mark a Task as Completed

To allow users to mark tasks as completed, we'll add a toggle next to each task in the list. Modify the `TodoItemView`
to include a `Button` for each task that toggles the task's `isCompleted` property.

```swift
struct TodoItemView: View {
    @Binding var todo: TodoItem

    var body: some View {
        HStack {
            Text(todo.name)
            Spacer()
            Button(action: {
                todo.isCompleted.toggle()
            }) {
                Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
            }
            .accessibilityLabel(Text(todo.isCompleted ? "Completed" : "Mark as Complete"))
        }
    }
}
```

(Note: You can also make this as elaborate as you want - the code in the solution branches is a bit more fleshed out.)

## Step 8: Using @ObservedObject for Task Editing

When you have data that needs to be shared across multiple views or when your data model involves more complex
interactions, `@ObservedObject` becomes invaluable. It allows views to observe changes in an object that conforms to the
`ObservableObject` protocol, making it perfect for scenarios like editing task details.

First, let's define a `TodoModel` that will act as an `@ObservedObject`. This view model will manage the list of tasks, as well as adding tasks and marking them as completed. Create a `TodoModel.swift` and implement the view model:

```swift
import Foundation

class TodoModel: ObservableObject {
    @Published private(set) var todos: [TodoItem] = []
    
    func createTodo(todo: TodoItem) {
        todos.append(todo)
    }
    
    func toggleComplete(id: UUID) {
        if let index = todos.firstIndex(where: { $0.id == id }) {
            if todos[index].isCompleted {
                todos[index].isCompleted = false
            } else {
                todos[index].isCompleted = true
                todos.move(fromOffsets: IndexSet(integer: index), toOffset: todos.endIndex)
            }
        }
    }
}
```

Then, update `TodoItemView` to use `TodoModel` as an `@ObservedObject`. This allows `TodoItemView` to tell `TodoModel` to mark a task as completed. We'll also remove the `@Binding` since the `TodoModel` will now take care of completing the task.

```swift
import SwiftUI

struct TodoItemView: View {
    @ObservedObject var todoModel: TodoModel
    var todo: TodoItem
    
    // ...
}
```

And change the `Button`'s action to call into the view model:

```swift
Button(action: {
    todoModel.toggleComplete(id: todo.id)
}) {
    Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
}
```

Now, we can update the `ContentView` to take in a view model:

```swift
struct ContentView: View {
    @ObservedObject var todoModel: TodoModel
    @State private var newTodoName = ""

    // ...
}
```

And we'll update the `List` to pass in the `TodoModel` and its todos to each `TodoItemView`:

```swift
List(todoModel.todos) { todo in
    TodoItemView(todoModel: todoModel, todo: todo)
}
```

Additionally, in `addNewTodo`, now use the model to append the new Todo instead:

```swift
private func addNewTodo() {
    let newTodo = TodoItem(name: newTodoName, isCompleted: false)
    todoModel.createTodo(todo: newTodo)
    newTodoName = "" // Reset input field
}
```

Finally, we'll need to construct our view model at the root of the app. Go ahead and add a `@StateObject` to the `TaskManagerApp` struct, and pass it into the `ContentView`:

```swift
@main
struct Task_ManagerApp: App {
    @StateObject var todoModel = TodoModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(todoModel: todoModel)
        }
    }
}
```

If any `#Preview` blocks are failing to compile, construct a `TodoModel` in there as well:

```swift
#Preview {
    ContentView(todoModel: TodoModel())
}
```

Normally you would never do the above without a `@StateObject`, but this is alright for a preview-only block in a small project like this.

## Step 9: Refactoring to Use `@EnvironmentObject` for `TodoModel`

Having to pass around `TodoModel` can get pretty annoying. Let's fix that by using `@EnvironmentObject` instead. In `ContentView` and `TodoItemView`, replace the `@ObservedObject` with something like this:

```swift
@EnvironmentObject var todoModel: TodoModel
```

Now, we can remove the `todoModel` parameter from whereever we instantiate `TodoItemView` in the `ContentView`:
```swift
TodoItemView(todo: todo)
```

We can also remove it inside TaskManagerApp.swift, but we'll need to replace it with `.environmentObject` to introduce our `TodoModel` into the view hierarchy in the first place:
```swift
ContentView()
    .environmentObject(todoModel)
```

Don't forget to update your `#Preview` blocks as well:
```swift
#Preview {
    ContentView()
        .environmentObject(TodoModel())
}
```

Now our code should be cleaner, with less prop drilling!

## Step 10: Add Animations When a Task is Completed

We can use animations to visually distinguish between active and completed tasks. For instance, when a task is marked
as completed, it could fade out or move to a different section of the UI. 

In our case, we'll make completed tasks fade with an animation, using just a few lines of code in `TodoItemView.swift`. Add these modifiers just after the `HStack`:
```swift
.opacity(todo.isCompleted ? 0.1 : 1)
.animation(.default, value: todo.isCompleted)
```

Et voilà! Now, completing a task should cause it to fade slightly with a pleasant animation. Feel free to experiment with your own sets of animations, or do something else entirely!

## Conclusion

Great! You've just created your first full app from scratch. You can now call yourself an iOS developer. 😎
