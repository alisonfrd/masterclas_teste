import 'package:modulo_tdd/reminders/domain/entities/reminder.dart';

abstract class ReminderRepository {
  Future<Reminder> getReminder(int id);
}
