// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:adda/model/saved_model.dart';
import 'package:adda/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static Widget progress() => Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      );
  static void toast(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          dismissDirection: DismissDirection.up,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          content: Text(message),
          backgroundColor: kRedColor,
        ),
      );
  static String? dateFormmatHelper(DateTime dateTime) {
    try {
      return DateFormat("dd-MM-yyyy").format(dateTime).toString();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static String? timeFormmatHelper(BuildContext context, TimeOfDay dateTime) {
    try {
      return MaterialLocalizations.of(context)
          .formatTimeOfDay(dateTime, alwaysUse24HourFormat: true);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<TimeOfDay?> getTime(BuildContext context, DateTime date) async {
    try {
      TimeOfDay? tempDate = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child!,
          );
        },
      );

      if (tempDate != null) {
        bool value = timeDateValidation(
          context: context,
          time: tempDate,
          date: date,
        );
        if (!value) {
          return tempDate;
        }
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  static bool timeDateValidation(
      {DateTime? date, required BuildContext context, TimeOfDay? time}) {
    if (date != null && time != null) {
      DateTime dateTime = DateTime.now();
      DateTime selectedTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      if (selectedTime.isBefore(dateTime)) {
        Helper.toast(context, "Start-End time should be of future");
        return true;
      }
    }
    return false;
  }

  static int? timeDifference(
      {required BuildContext context,
      required String s,
      required String e,
      required DateTime? dateTime}) {
    try {
      if (dateTime == null || s.isEmpty || e.isEmpty) {
        return null;
      } else {
        TimeOfDay tempStartTime = TimeOfDay(
          hour: int.parse(s.trim().split(":").first),
          minute: int.parse(s.trim().split(":").last),
        );
        TimeOfDay tempEndTime = TimeOfDay(
          hour: int.parse(e.trim().split(":").first),
          minute: int.parse(e.trim().split(":").last),
        );
        DateTime sTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
            tempStartTime.hour, tempStartTime.minute);
        DateTime eTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
            tempEndTime.hour, tempEndTime.minute);

        Duration duration = eTime.difference(sTime);
        log(duration.inHours.toString());

        if (duration.inHours < 0) {
          Helper.toast(context, "Invalid Start and End time");
        } else if (duration.inHours == 0) {
          Helper.toast(context, "Start and End time must be more then 1 hours");
        } else {
          return duration.inHours;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static int? calculateTotal(SavedBookingModel savedModel) {
    if (savedModel.bookingType == "ClubHouse" &&
        savedModel.startTime != null &&
        savedModel.endTime != null &&
        savedModel.difference != null) {
      if (savedModel.startTime!.hour > 0 && savedModel.endTime!.hour < 16) {
        return savedModel.difference! * 100;
      } else if (savedModel.startTime!.hour >= 16 &&
          savedModel.endTime!.hour <= 23) {
        return savedModel.difference! * 500;
      } else if (savedModel.startTime!.hour < 16 &&
          savedModel.endTime!.hour > 23) {
        int v1 = (16 - savedModel.startTime!.hour) * 100;
        int v2 = (savedModel.endTime!.hour - 16) * 500;
        return v1 + v2;
      } else {
        return savedModel.difference! * 100;
      }
    }
    if (savedModel.bookingType == "Tennis") {
      return savedModel.difference! * 50;
    }
    return null;
  }
}
