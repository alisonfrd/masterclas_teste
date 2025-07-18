import 'package:equatable/equatable.dart';

class Reminder extends Equatable {
  final int id;
  final String title;
  final String description;

  const Reminder(
      {required this.id, required this.title, required this.description});

  @override
  List<Object?> get props => [id, title, description];
}
