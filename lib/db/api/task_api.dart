import 'package:atlaslabs_test/db/model/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskApi {
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  Future addTaskEnd(Task task) async {
    try {
      final doc = await tasks.add(task.toJson());
      print("addTaskEnd: ${doc.id}");
      return doc;
    } catch (e) {
      print("Add-Task Endpoint Error Message: "+e.toString());
    }
  }

  Future<List<Task>> getAllTasks({String query = ""}) async {
    List<Task> list = [];
    try {
      if (query == "") {
        final u = await tasks.where('taskName', isNotEqualTo: "").get();
        for (int i = 0; i < u.docs.length; i++) {
          final Task task = Task(
              taskName: u.docs[i]['taskName'],
              taskDes: u.docs[i]['taskDes'],
              taskDueDate: u.docs[i]['taskDueDate']);
          list.add(task);
        }
      } else {
        final u = await tasks
            .where('taskName', isGreaterThanOrEqualTo: query)
            .where('taskName', isLessThan: query + 'z')
            .get();
        for (int i = 0; i < u.docs.length; i++) {
          final Task task = Task(
              taskName: u.docs[i]['taskName'],
              taskDes: u.docs[i]['taskDes'],
              taskDueDate: u.docs[i]['taskDueDate']);
          list.add(task);
        }
      }
      return list;
    } catch (e) {
      print("Getall-Task Endpoint Error Message: "+e.toString());
      return list;
    }
  }

  Future updateTask(Task task,String taskName) async {
    try {
      final loc = await tasks
          .where('taskName', isEqualTo: taskName)
          .limit(1)
          .get();
      final doc = loc.docs.first;
      await tasks.doc(doc.id).update(task.toJson());
      return doc;
    } catch (e) {
      print("Update-Task Endpoint Error Message: "+e.toString());
    }
  }

  Future deleteTask(Task task) async {
    try {
      final loc = await tasks
          .where('taskName', isEqualTo: task.taskName)
          .limit(1)
          .get();
      final doc = loc.docs.first;
      await tasks.doc(doc.id).delete();
      return doc;
    } catch (e) {
      print("Delete-Task Endpoint Error Message: "+e.toString());
    }
  }
}
