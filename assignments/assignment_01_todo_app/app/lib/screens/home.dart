import 'package:flutter/material.dart';
import 'package:to_do_flutter/model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: tdBGColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  'assets/images/avatar.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text("ALL ToDos",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500))),
                  for (ToDo todoo in todoList.reversed)
                    ToDoItem(
                      todo: todoo,
                      onToDoChange: _handelToDochange,
                      onDeleteItem: _deleteToDoItem,
                    ),
                ],
              ))
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                            hintText: "Add a new todo item",
                            border: InputBorder.none),
                      ))),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        minimumSize: Size(60, 60),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero)),
                    child: Text(
                      "+",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    )),
              )
            ],
          ),
        )
      ]),
    );
  }

  void _handelToDochange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    _todoController.clear();
  }
}
