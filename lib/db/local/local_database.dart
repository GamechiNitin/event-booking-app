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

      log(res.toJson().toString());
      return val;
    } else {
      bool check =
          savedList.any((element) => element.uuid == bookingModel.uuid);
      bool samedate = savedList.any((element) =>
          (element.date == bookingModel.date &&
              element.formatedStartTime == bookingModel.formatedStartTime &&
              element.formatedEndTime == bookingModel.formatedEndTime));

      if (!check && !samedate) {
        savedList.add(bookingModel);
        var res = BookingResponse(results: savedList);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        bool val =
            await sharedPreferences.setString("pref", jsonEncode(res.toJson()));

        log(res.toJson().toString());
        return val;
      } else if (samedate) {
        Helper.toast(context, "Already booked the activites for this date");
        return false;
      } else {
        Helper.toast(context, "Already activities exit");
        return false;
      }
    }
  }

  static Future<bool> saveSlots2(List<BookingModel> bookingModelList) async {
    var res = BookingResponse(results: bookingModelList);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool val =
        await sharedPreferences.setString("pref", jsonEncode(res.toJson()));

    log(res.toJson().toString());
    return val;
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
}
