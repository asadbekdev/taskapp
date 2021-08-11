class TaskClass {
  String? taskTitle;
  String? taskSubtitle;
  String? taskTime;

  TaskClass(this.taskTitle);


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['taskTitle'] = taskTitle;
    map['taskSubtitle'] = taskSubtitle;
    map['taskTime'] = taskTime;
    return map;
  }

  TaskClass.fromMap(Map<String, dynamic> map) {
    this.taskTitle = map['taskTitle'];
    this.taskSubtitle = map['taskSubtitle'];
    this.taskTime = map['taskTime'];
  }
}
