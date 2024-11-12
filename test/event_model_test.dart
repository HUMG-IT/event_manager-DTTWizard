import 'package:flutter_test/flutter_test.dart';
import 'package:event_manager/event/event_model.dart';

void main() {
  group('EventModel Tests', () {
    test('EventModel instantiation', () {
      final event = EventModel(
        id: '1',
        startTime: DateTime(2023, 10, 1, 10, 0),
        endTime: DateTime(2023, 10, 1, 12, 0),
        isAllDay: false,
        subject: 'Meeting',
        notes: 'Discuss project updates',
        recurrenceRule: 'FREQ=DAILY;COUNT=10',
      );

      expect(event.id, '1');
      expect(event.startTime, DateTime(2023, 10, 1, 10, 0));
      expect(event.endTime, DateTime(2023, 10, 1, 12, 0));
      expect(event.isAllDay, false);
      expect(event.subject, 'Meeting');
      expect(event.notes, 'Discuss project updates');
      expect(event.recurrenceRule, 'FREQ=DAILY;COUNT=10');
    });

   test('EventModel copyWith test', () {
  final original = EventModel(
    id: '123',
    event: 'Event 1',
    startTime: DateTime(2023, 12, 25, 8, 30),
    endTime: DateTime(2023, 12, 25, 9, 30),
    isAllDay: false,
    subject: 'Subject 1',
    notes: 'Notes 1',
    recurrenceRule: 'None',
  );

  final modified = original.copyWith(event: 'Modified Event');

  // Kiểm tra các thuộc tính đã được sửa đổi
  expect(modified.event, 'Modified Event');

  // Kiểm tra các thuộc tính không thay đổi
  expect(modified.id, original.id);
  expect(modified.startTime, original.startTime);
  expect(modified.endTime, original.endTime);
  expect(modified.isAllDay, original.isAllDay);
  expect(modified.subject, original.subject);
  expect(modified.notes, original.notes);
  expect(modified.recurrenceRule, original.recurrenceRule);
});


    test('EventModel toMap and fromMap', () {
      final event = EventModel(
        id: '1',
        startTime: DateTime(2023, 10, 1, 10, 0),
        endTime: DateTime(2023, 10, 1, 12, 0),
        subject: 'Meeting', notes: '', recurrenceRule: '',
      );

      final map = event.toMap();
      final newEvent = EventModel.fromMap(map);

      expect(newEvent, equals(event));
    });

    test('EventModel toJson and fromJson', () {
      final event = EventModel(
        id: '2',
        startTime: DateTime(2023, 11, 1, 9, 0),
        endTime: DateTime(2023, 11, 1, 11, 0),
        subject: 'Conference',
        isAllDay: false,
        notes: '',
        recurrenceRule: '',
      );

      final jsonStr = event.toJson();
      final newEvent = EventModel.fromJson(jsonStr);

      expect(newEvent, equals(event));
    });

    test('EventModel formatted time strings test', () {
  final event = EventModel(
    startTime: DateTime(2023, 12, 25, 8, 30),
    endTime: DateTime(2023, 12, 25, 9, 30),
    isAllDay: false,
    subject: 'Test Subject',
    notes: 'Test Notes',
    recurrenceRule: 'None',
  );

  // Kiểm tra chuỗi thời gian đã định dạng
  expect(event.formattedStartTimeString, '8:30, 25/12/2023');
  expect(event.formattedEndTimeString, '9:30, 25/12/2023');
});
  });
}
