class TaskStatusMdel {
  final String id;
  final dynamic sum;

  TaskStatusMdel({required this.id, required this.sum});

  factory TaskStatusMdel.fromJson(Map<String, dynamic>jsondata){
    return TaskStatusMdel(
        id: jsondata["_id"],
        sum: jsondata["sum"]
    );
  }
}