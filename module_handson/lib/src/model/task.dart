import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String description;
  bool check;

  Task({
    required this.id,
    required this.description,
    this.check = false,
  });

  @override
  List<Object?> get props => [id, description, check];

  Task copyWith({
    int? id,
    String? description,
    bool? check,
  }) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      check: check ?? this.check,
    );
  }
}
