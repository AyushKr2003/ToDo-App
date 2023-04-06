class ToDo {
  String? id;
  String? todotext;
  bool isDone;

  ToDo({
    required this.id,
    required this.todotext,
    this.isDone=false,
});
  static List<ToDo> todoList(){
    return [
      ToDo(id: '01', todotext: 'Mornig Exer',isDone: true),
      ToDo(id: '02', todotext: 'todo',isDone: true),
      ToDo(id: '03', todotext: 'good moring'),
      ToDo(id: '04', todotext: 'done job'),
      ToDo(id: '05', todotext: 'joker'),

    ];
  }
}