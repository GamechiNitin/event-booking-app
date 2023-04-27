// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:adda/model/booking_model.dart';
import 'package:adda/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataBase {
  static Future<bool> saveSlots(
      BookingModel bookingModel, BuildContext context) async {
    List<BookingModel> savedList = await getSaveSlots();
    if (savedList.isEmpty) {
      List<BookingModel> bookingModelList = [];
      bookingModelList.add(bookingModel);
      var res = BookingResponse(results: bookingModelList);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool val =
          await sharedPreferences.setString("pref", jsonEncode(res.toJson()));

      return val;
    } else {
      bool val = await checkDBBooking(
          context: context,
          newBookingModelEntry: bookingModel,
          savedDataList: savedList);
      if (val == false) {
        savedList.add(bookingModel);
        var res = BookingResponse(results: savedList);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        bool val =
            await sharedPreferences.setString("pref", jsonEncode(res.toJson()));

        log(res.toJson().toString());
        return val;
      }
    }
    return false;
  }

  static Future<List<BookingModel>> getSaveSlots() async {
    List<BookingModel> bookingModelList = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.clear();
    String? data = sharedPreferences.getString("pref");

    if (data != null) {
      try {
        BookingResponse bookingResponse =
            BookingResponse.fromJson(jsonDecode(data));
        if (bookingResponse.results != null) {
          return bookingResponse.results!;
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return bookingModelList;
  }

  static void clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  static Future<bool> checkDBBooking({
    required List<BookingModel> savedDataList,
    required BookingModel newBookingModelEntry,
    required BuildContext context,
  }) async {
    if (savedDataList.isNotEmpty &&
        newBookingModelEntry.date != null &&
        newBookingModelEntry.fullStartDateTime != null &&
        newBookingModelEntry.fullEndDateTime != null) {
      DateTime sDatetime =
          DateTime.parse(newBookingModelEntry.fullStartDateTime!);
      DateTime eDatetime =
          DateTime.parse(newBookingModelEntry.fullEndDateTime!);
      if (savedDataList
          .any((element) => element.uuid == newBookingModelEntry.uuid)) {
        Helper.toast(context, "Something went wrong! Try again later");
        return true;
      } else {
        for (var element in savedDataList) {
          if (element.bookingType == newBookingModelEntry.bookingType &&
              element.date == newBookingModelEntry.date) {
            if (DateTime.parse(element.fullStartDateTime!) == sDatetime ||
                DateTime.parse(element.fullEndDateTime!) == eDatetime) {
              Helper.toast(context, "Booking Failed! Already Booked");
              return true;
            } else {
              if (DateTime.parse(element.fullStartDateTime!)
                      .isAfter(sDatetime) &&
                  DateTime.parse(element.fullEndDateTime!)
                      .isBefore(eDatetime)) {
                Helper.toast(context, "Booking Failed! Already Booked");
                return true;
              }

              if ((DateTime.parse(element.fullStartDateTime!)
                          .isBefore(eDatetime) &&
                      DateTime.parse(element.fullStartDateTime!)
                          .isAfter(sDatetime)) ||
                  (DateTime.parse(element.fullEndDateTime!)
                          .isBefore(eDatetime) &&
                      DateTime.parse(element.fullEndDateTime!)
                          .isAfter(sDatetime)) ||
                  (DateTime.parse(element.fullStartDateTime!)
                          .isBefore(sDatetime) &&
                      DateTime.parse(element.fullEndDateTime!)
                          .isAfter(eDatetime))) {
                Helper.toast(context,
                    "Booking Failed! Already Booked Overlap Timeslots");
                return true;
              }
            }
          }
        }
      }
    }
    return false;
  }
}
