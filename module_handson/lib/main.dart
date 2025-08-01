import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_handson/src/cubits/board_cubit.dart';
import 'package:module_handson/src/pages/board_page.dart';
import 'package:module_handson/src/repositories/board_repository.dart';
import 'package:module_handson/src/repositories/isar/isar_board_repository.dart';
import 'package:module_handson/src/repositories/isar/isar_datasource.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => IsarDatasource(),
        ),
        RepositoryProvider<BoardRepository>(
            create: (context) => IsarBoardRepository(context.read())),
        BlocProvider(create: (context) => BoardCubit(context.read()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BoardPage(),
      ),
    );
  }
}
