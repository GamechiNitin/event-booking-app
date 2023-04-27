import 'package:flutter/material.dart';

enum SlotsEnum {
  night(
    "4:00 PM - 10:00 PM",
    "16:00",
    "22:00",
    TimeOfDay(hour: 16, minute: 00),
    TimeOfDay(hour: 22, minute: 00),
  ),
  morning(
    "10:00 AM - 4:00 PM",
    "10:00",
    "16:00",
    TimeOfDay(hour: 10, minute: 00),
    TimeOfDay(hour: 16, minute: 00),
  );

  final String data;
  final String startTime;
  final TimeOfDay startTimeTimeOfDay;
  final TimeOfDay endTimeTimeOfDay;
  final String endTime;
  const SlotsEnum(this.data, this.startTime, this.endTime,
      this.startTimeTimeOfDay, this.endTimeTimeOfDay);
}
