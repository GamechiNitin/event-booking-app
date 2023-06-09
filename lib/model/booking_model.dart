class BookingResponse {
  List<BookingModel>? results;

  BookingResponse({this.results});

  BookingResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <BookingModel>[];
      json['results'].forEach((v) {
        results!.add(BookingModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingModel {
  int? total;
  String? date;
  String? formatedDate;
  String? uuid;
  String? fullStartDateTime;
  String? fullEndDateTime;
  String? formatedStartTime;
  String? formatedEndTime;
  int? difference;
  String? bookingType;
  String? desc;

  BookingModel({
    this.total,
    this.uuid,
    this.date,
    this.formatedDate,
    this.fullStartDateTime,
    this.fullEndDateTime,
    this.formatedStartTime,
    this.formatedEndTime,
    this.difference,
    this.bookingType,
    this.desc,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    uuid = json['uuid'];
    date = json['date'];
    fullStartDateTime = json['fullStartDateTime'];
    fullEndDateTime = json['fullEndDateTime'];
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
    data['fullStartDateTime'] = fullStartDateTime;
    data['date'] = date;
    data['fullEndDateTime'] = fullEndDateTime;
    data['difference'] = difference;
    data['bookingType'] = bookingType;
    data['desc'] = desc;

    return data;
  }
}
