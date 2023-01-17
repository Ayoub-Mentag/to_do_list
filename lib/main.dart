import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do list',
      home: TodoList(),
    );
  }
}


class TodoList extends StatefulWidget {
  @override
  TodoListState createState() => TodoListState();
}



class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

// Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Mark "${_todoItems[index]}" as done?'),
              actions: <Widget>[
                TextButton(
                    child: const Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                TextButton(
                    child: const Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }


  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
    // Putting our code inside "setState" tells the app that our state has changed, and
    // it will automatically re-render the list
    if (task.isNotEmpty)
    {
      setState(() => _todoItems.add(task));
    }
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
        else
        {
            return const SizedBox(width: 5, height: 5,);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    return ListTile(
        title: Text(todoText),
        onTap: () => _promptRemoveTodoItem(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Todo List')
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: const Icon(Icons.add)
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Add a new task'),
              ),
              body: TextField(
                autofocus: true,
                onSubmitted: (val) {
                  _addTodoItem(val);
                  Navigator.pop(context);
                },
                decoration: const InputDecoration(
                  hintText: 'Enter something to do ...',
                  contentPadding: EdgeInsets.all(16.0)
                ),
              ),
            );
          }
      )
    );
  }
}


