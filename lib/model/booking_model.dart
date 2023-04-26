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
  String? formatedDate;
  String? uuid;
  String? formatedStartTime;
  String? formatedEndTime;
  String? date;
  int? difference;
  String? bookingType;
  String? desc;

  BookingModel({
    this.total,
    this.uuid,
    this.formatedDate,
    this.formatedStartTime,
    this.formatedEndTime,
    this.date,
    this.difference,
    this.bookingType,
    this.desc,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    uuid = json['uuid'];
    formatedDate = json['formatedDate'];
    formatedStartTime = json['formatedStartTime'];
    date = json['date'];
    difference = json['difference'];
    bookingType = json['bookingType'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['uuid'] = uuid;
    data['formatedDate'] = formatedDate;
    data['formatedStartTime'] = formatedStartTime;
    data['date'] = date;
    data['difference'] = difference;
    data['bookingType'] = bookingType;
    data['desc'] = desc;

    return data;
  }
}
