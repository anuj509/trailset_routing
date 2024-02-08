import 'package:flutter/material.dart';

Future<TimeOfDay?> openTimePicker(BuildContext context) async {
  TimeOfDay? timeOfDay =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  return timeOfDay;
}
