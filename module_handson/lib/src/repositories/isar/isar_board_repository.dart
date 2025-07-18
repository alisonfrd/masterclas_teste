import 'package:module_handson/src/model/task.dart';
import 'package:module_handson/src/repositories/board_repository.dart';
import 'package:module_handson/src/repositories/isar/isar_datasource.dart';
import 'package:module_handson/src/repositories/isar/task_model.dart';

class IsarBoardRepository implements BoardRepository {
  final IsarDatasource datasource;

  IsarBoardRepository(this.datasource);
  @override
  Future<List<Task>> fetch() async {
    final models = await datasource.getTasks();
    return models
        .map((e) => Task(id: e.id, description: e.description, check: e.check))
        .toList();
  }

  @override
  Future<List<Task>> update(List<Task> task) async {
    final models = task.map((e) {
      final model = TaskModel()
        ..description = e.description
        ..check = e.check;
      if (e.id != -1) {
        model.id = e.id;
      }
      return model;
    }).toList();
    await datasource.deleteAllTasks();
    await datasource.putAllTasks(models);
    return task;
  }
}
