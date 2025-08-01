import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:module_handson/src/cubits/board_cubit.dart';
import 'package:module_handson/src/pages/board_page.dart';
import 'package:module_handson/src/repositories/board_repository.dart';

class BoardRepositoryMock extends Mock implements BoardRepository {}

void main() {
  late BoardRepository repository;
  late BoardCubit cubit;

  setUp(
    () {
      repository = BoardRepositoryMock();
      cubit = BoardCubit(repository);
    },
  );

  testWidgets('board page with all tasks', (tester) async {
    when(() => repository.fetch()).thenAnswer((invocation) async => []);
    await tester.pumpWidget(
      BlocProvider.value(
          value: cubit,
          child: const MaterialApp(
            home: BoardPage(),
          )),
    );

    expect(find.byKey(const Key('EmptyState')), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(find.byKey(const Key('GettedState')), findsOneWidget);
  });

  testWidgets('board page with all - failure state', (tester) async {
    when(() => repository.fetch()).thenThrow(Exception('error'));
    await tester.pumpWidget(
      BlocProvider.value(
          value: cubit,
          child: const MaterialApp(
            home: BoardPage(),
          )),
    );

    expect(find.byKey(const Key('EmptyState')), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(find.byKey(const Key('FailureState')), findsOneWidget);
  });
}
