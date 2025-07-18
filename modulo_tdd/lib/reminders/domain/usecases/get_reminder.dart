import 'package:modulo_tdd/reminders/domain/entities/reminder.dart';

import '../repositories/reminder_repository.dart';

class GetReminder {
  final ReminderRepository repository;

  GetReminder(this.repository);

  Future<Reminder> execute(int id) async {
    return repository.getReminder(id);
  }
}
