import 'package:mocktail/mocktail.dart';
import 'package:modulo_tdd/reminders/domain/entities/reminder.dart';
import 'package:modulo_tdd/reminders/domain/repositories/reminder_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modulo_tdd/reminders/domain/usecases/get_reminder.dart';

class ReminderRepositoryMock extends Mock implements ReminderRepository {}

void main() async {
  late GetReminder usecase;
  late ReminderRepository repository;

  setUp(() {
    repository = ReminderRepositoryMock();
    usecase = GetReminder(repository);
  });

  test(
    'Should be retunro an entity reminder',
    () async {
      //arrange
      when(
        () => repository.getReminder(any()),
      ).thenAnswer((_) async =>
          const Reminder(id: 1, title: 'title', description: 'description'));
      //act
      final result = await usecase.execute(1);
      //asset
      expect(result, isA<Reminder>());
    },
  );
}
