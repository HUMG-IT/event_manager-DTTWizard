import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'event_model.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<EventModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    final event = appointments![index] as EventModel;
    return event.startTime;
  }

  @override
  DateTime getEndTime(int index) {
    final event = appointments![index] as EventModel;
    return event.endTime;
  }

  @override
  String getSubject(int index) {
    final event = appointments![index] as EventModel;
    return event.subject;
  }

  @override
  String? getNotes(int index) {
    final event = appointments![index] as EventModel;
    return event.notes;
  }

  @override
  bool isAllDay(int index) {
    final event = appointments![index] as EventModel;
    return event.isAllDay;
  }

  @override
  String? getRecurrenceRule(int index) {
    final event = appointments![index] as EventModel;
    return event.recurrenceRule;
  }

  @override
  Color getColor(int index) {
    final event = appointments![index] as EventModel;
    return event.isAllDay ? const Color(0xFFE0E0E0) : Colors.blue; 
  }
}
