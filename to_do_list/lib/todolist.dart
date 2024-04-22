import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
  @override
  ToDoListPageState createState() => ToDoListPageState();
}

class ToDoListPageState extends State<ToDoListPage> {
  List<String> todos = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addTask(BuildContext context) async {
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
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                User? user = _auth.currentUser;
                if (user != null) {
                  await _firestore
                      .collection('users')
                      .doc(user.uid)
                      .collection('todos')
                      .add({
                    'task': newToDoList,
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> confirmDelete(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm"),
          content: Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Dismiss the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm deletion
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void removeTask(int index) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('todos')
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          if (doc['task'] == todos[index]) {
            doc.reference.delete();
          }
        }
      });
    }
    todos.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Task deleted")),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    if (user == null) {
      // Handle the case where the user is not logged in
      return Scaffold(
        body: Center(
          child: Text("Please log in to view your To-Do List"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Your To-Do List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream: _firestore
                    .collection('users')
                    .doc(user.uid)
                    .collection('todos')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    todos.clear();
                    for (var doc in snapshot.data!.docs) {
                      todos.add(doc['task']);
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(todos[index]),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.red,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (direction) async {
                            return await confirmDelete(context);
                          },
                          onDismissed: (direction) {
                            removeTask(index);
                          },
                          child: Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                todos[index],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: todos.length,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                addTask(context);
              },
              child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
