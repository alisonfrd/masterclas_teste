import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_handson/src/cubits/board_cubit.dart';
import 'package:module_handson/src/model/task.dart';
import 'package:module_handson/src/states/board_state.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BoardCubit>().fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<BoardCubit>();
    final state = cubit.state;
    Widget body = Container();

    if (state is EmptyBoardState) {
      body = const Center(
        key: Key('EmptyState'),
        child: Text('Adicione uma nova Task'),
      );
    } else if (state is GettedTaskBoardState) {
      final tasks = state.tasks;
      body = ListView.builder(
        key: const Key('GettedState'),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return CheckboxListTile(
            value: task.check,
            title: Text(task.description),
            onChanged: (value) {
              cubit.checkTask(task);
            },
          );
        },
      );
    } else if (state is FailureBoardState) {
      body = const Center(
        key: Key('FailureState'),
        child: Text('Falha ao pegar as tasks'),
      );
    }

    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void addTask() {
    var description = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Sair')),
            TextButton(
                onPressed: () {
                  final task = Task(id: -1, description: description);
                  context.read<BoardCubit>().addTask(task);
                  Navigator.pop(context);
                },
                child: const Text('Criar'))
          ],
          title: const Text('Adicionar uma task'),
          content: TextField(
            onChanged: (value) {
              description = value;
            },
          ),
        );
      },
    );
  }
}
