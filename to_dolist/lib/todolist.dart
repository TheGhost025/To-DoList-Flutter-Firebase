import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
  @override
  ToDoListPageState createState() => ToDoListPageState();
}

class ToDoListPageState extends State<ToDoListPage> {
  List<String> todos = [];

  void addTask(BuildContext context) {
    String newToDoList = "";

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add new Task"),
            content: TextField(
              onChanged: (value) {
                newToDoList = value;
              },
              decoration: InputDecoration(hintText: "Enter Your Task ....."),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (newToDoList.isNotEmpty) {
                        todos.add(newToDoList);
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Text("Add"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          Text(
            "Your To-Do List",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    todos[index],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            },
            itemCount: todos.length,
          )),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () {
                addTask(context);
              },
              child: Text("Add Task"))
        ]),
      ),
    );
  }
}
