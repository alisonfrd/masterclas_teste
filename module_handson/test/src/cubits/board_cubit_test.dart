import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:module_handson/src/cubits/board_cubit.dart';
import 'package:module_handson/src/model/task.dart';
import 'package:module_handson/src/repositories/board_repository.dart';
import 'package:module_handson/src/states/board_state.dart';

class BoardRepositoryMock extends Mock implements BoardRepository {}

void main() {
  late BoardRepositoryMock repository = BoardRepositoryMock();
  late BoardCubit cubit;
  setUp(
    () {
      repository = BoardRepositoryMock();
      cubit = BoardCubit(repository);
    },
  );
  group(
    'fecthTasks | ',
    () {
      test('deve pegar todas as taks', () async {
        when(
          () => repository.fetch(),
        ).thenAnswer((_) async => []);
        expect(
            cubit.stream,
            emitsInOrder([
              isA<LoadingBoardState>(),
              isA<GettedTaskBoardState>(),
            ]));

        await cubit.fetchTasks();
      });

      test(
        'Deve retornar um estado de erro ao falhar',
        () async {
          when(
            () => repository.fetch(),
          ).thenThrow(Exception());

          expect(
              cubit.stream,
              emitsInOrder([
                isA<LoadingBoardState>(),
                isA<FailureBoardState>(),
              ]));

          await cubit.fetchTasks();
        },
      );
    },
  );

  group(
    'addTask | ',
    () {
      test('Deve adiconar uma task a lista', () async {
        when(() => repository.update(any())).thenAnswer((_) async => []);
        expect(
            cubit.stream,
            emitsInOrder([
              isA<GettedTaskBoardState>(),
            ]));
        final task = Task(id: 1, description: '');
        await cubit.addTask(task);
        final state = cubit.state as GettedTaskBoardState;
        expect(state.tasks.length, 1);
        expect(state.tasks, [task]);
      });

      test(
        'Deve retornar um estado de erro ao falhar',
        () async {
          when(() => repository.update(any())).thenThrow(Exception('Error'));

          expect(
              cubit.stream,
              emitsInOrder([
                isA<FailureBoardState>(),
              ]));
          final task = Task(id: 1, description: '');
          await cubit.addTask(task);
        },
      );
    },
  );

  group(
    'removeTask | ',
    () {
      test('Deve remover uma task ta lista', () async {
        when(() => repository.update(any())).thenAnswer((_) async => []);
        final task = Task(id: 1, description: '');
        cubit.addTasks([task]);
        expect(
            cubit.stream,
            emitsInOrder([
              isA<GettedTaskBoardState>(),
            ]));

        await cubit.removeTask(task);
        final state = cubit.state as GettedTaskBoardState;
        expect(state.tasks.length, 0);
      });

      test(
        'Deve retornar um estado de erro ao falhar',
        () async {
          when(() => repository.update(any())).thenThrow(Exception('Error'));
          final task = Task(id: 1, description: '');
          cubit.addTasks([task]);
          expect(
              cubit.stream,
              emitsInOrder([
                isA<FailureBoardState>(),
              ]));

          await cubit.removeTask(task);
        },
      );
    },
  );

  group(
    'checkTask | ',
    () {
      test('Deve checkar uma task na lista', () async {
        when(() => repository.update(any())).thenAnswer((_) async => []);

        final task = Task(id: 1, description: '');
        cubit.addTasks([task]);

        expect((cubit.state as GettedTaskBoardState).tasks.length, 1);
        expect((cubit.state as GettedTaskBoardState).tasks.first.check, false);

        expect(
            cubit.stream,
            emitsInOrder([
              isA<GettedTaskBoardState>(),
            ]));

        await cubit.checkTask(task);
        var state = cubit.state as GettedTaskBoardState;

        expect(state.tasks.length, 1);
        expect(state.tasks.first.check, true);
      });

      test(
        'Deve retornar um estado de erro ao falhar',
        () async {
          when(() => repository.update(any())).thenThrow(Exception('Error'));
          final task = Task(id: 1, description: '');
          cubit.addTasks([task]);
          expect(
              cubit.stream,
              emitsInOrder([
                isA<FailureBoardState>(),
              ]));

          await cubit.checkTask(task);
        },
      );
    },
  );
}
