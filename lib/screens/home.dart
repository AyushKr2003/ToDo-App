import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/widgets/todo_item.dart';
import 'package:todo/model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> fondToDo =[];
  final todoControler = TextEditingController();

  @override
  void initState() {
    fondToDo = todosList;
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchbox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 30),
                        ),
                      ),
                      for (ToDo todo in fondToDo)
                        ToDoItem(
                          todo: todo,
                          onToDoChanged: handleToDoChange,
                          onDeleteItem: deleteItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 10,
                            spreadRadius: 0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: todoControler,
                      decoration: InputDecoration(
                          hintText: 'Add new todo item',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      addToDoItem(todoControler.text);
                    },
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: tdBlue, minimumSize: Size(60, 60), elevation:10),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });

  }

  void deleteItem(String id){
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void addToDoItem(String toDo){
    setState(() {
      todosList.add(ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(), todotext: toDo));
    });
    todoControler.clear();
  }

  void runFilter(String enterKeyword){
    List<ToDo> result =[];
    if(enterKeyword.isEmpty){
      result = todosList;
    }
    else{
      result = todosList.where((item) => item.todotext!.toLowerCase().contains(enterKeyword.toLowerCase())).toList();
    }
    setState(() {
      fondToDo = result;
    });
  }

  Widget searchbox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
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
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/img1.png'),
            ),
          )
        ],
      ),
    );
  }
}
