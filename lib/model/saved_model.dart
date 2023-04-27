
import 'package:flutter/material.dart';

class SavedBookingModel {
  int? total;
  DateTime? date;
  String? formatedDate;
  String? uuid;
  TimeOfDay? startTime;
  String? formatedStartTime;
  String? formatedEndTime;
  TimeOfDay? endTime;
  int? difference;
  String? bookingType;
  String? desc;

  SavedBookingModel({
    this.total,
    this.uuid,
    this.date,
    this.formatedDate,
    this.startTime,
    this.endTime,
    this.formatedStartTime,
    this.formatedEndTime,
    this.difference,
    this.bookingType,
    this.desc,
  });

  SavedBookingModel.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    uuid = json['uuid'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    formatedDate = json['formatedDate'];
    formatedStartTime = json['formatedStartTime'];
    formatedEndTime = json['formatedEndTime'];
    difference = json['difference'];
    bookingType = json['bookingType'];
    desc = json['desc'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['uuid'] = uuid;
    data['formatedDate'] = formatedDate;
    data['formatedStartTime'] = formatedStartTime;
    data['formatedEndTime'] = formatedEndTime;
    data['startTime'] = startTime;
    data['date'] = date;
    data['endTime'] = endTime;
    data['difference'] = difference;
    data['bookingType'] = bookingType;
    data['desc'] = desc;

    return data;
  }
}