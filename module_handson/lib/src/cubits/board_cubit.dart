import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:module_handson/src/model/task.dart';
import 'package:module_handson/src/repositories/board_repository.dart';
import 'package:module_handson/src/states/board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  final BoardRepository repository;
  BoardCubit(this.repository) : super(EmptyBoardState());

  Future<void> fetchTasks() async {
    emit(LoadingBoardState());
    try {
      final tasks = await repository.fetch();
      emit(GettedTaskBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(e.toString()));
    }
  }

  Future<void> addTask(Task newTask) async {
    final tasks = _getList();
    if (tasks == null) return;
    tasks.add(newTask);
    await _emitsTasks(tasks);
  }

  Future<void> removeTask(Task task) async {
    final tasks = _getList();
    if (tasks == null) return;
    tasks.remove(task);
    await _emitsTasks(tasks);
  }

  Future<void> checkTask(Task task) async {
    final tasks = _getList();
    if (tasks == null) return;
    final index = tasks.indexOf(task);
    tasks[index] = task.copyWith(check: !task.check);
    await _emitsTasks(tasks);
  }

  @visibleForTesting
  void addTasks(List<Task> tasks) {
    emit(GettedTaskBoardState(tasks: tasks));
  }

  List<Task>? _getList() {
    final state = this.state;
    if (state is! GettedTaskBoardState) {
      return null;
    }
    return state.tasks.toList();
  }

  Future<void> _emitsTasks(List<Task> tasks) async {
    try {
      await repository.update(tasks);
      emit(GettedTaskBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(e.toString()));
    }
  }
}
