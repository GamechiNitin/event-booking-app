// ignore_for_file: use_build_context_synchronously
import 'package:adda/db/local/local_database.dart';
import 'package:adda/model/booking_model.dart';
import 'package:adda/model/saved_model.dart';
import 'package:adda/utils/color.dart';
import 'package:adda/utils/constant.dart';
import 'package:adda/utils/dialog_box.dart';
import 'package:adda/utils/dimens.dart';
import 'package:adda/utils/helper.dart';
import 'package:adda/view/booking/ui/booking.dart';
import 'package:adda/view/widget/textfield_widget.dart';
import 'package:adda/view/widget/timeslot_widget.dart';
import 'package:adda/view/widget/total_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<String> listData = ["ClubHouse", "Tennis"];
  static TextEditingController dateController = TextEditingController();
  static TextEditingController startTimeController = TextEditingController();
  static TextEditingController endTimeController = TextEditingController();
  static TextEditingController descController = TextEditingController();
  static FocusNode fn = FocusNode();
  static FocusNode startfn = FocusNode();
  static FocusNode endfn = FocusNode();
  static FocusNode descfn = FocusNode();
  // static DateTime? selectedDate;
  static int? total;
  static bool isSelectedTimeSlots = false;
  static bool isSelectedTimeSlots2 = false;
  static bool calculated = false;
  static bool isLoading = false;

  SavedBookingModel savedModel = SavedBookingModel();

  _refresh() {
    // selectedDate = null;
    // timeDifference = null;
    total = null;
    savedModel = SavedBookingModel();
    // selectedValue = null;
    dateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    descController.clear();
    isSelectedTimeSlots = false;
    isSelectedTimeSlots2 = false;
    calculated = false;
    _notify();
  }

  _changeLoading(bool iisLoading) {
    isLoading = iisLoading;
    _notify();
  }

  _notify() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adda"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DialogBox.dialogSlot();
                },
              );
            },
            icon: Icon(
              Icons.info_outline_rounded,
              color: kWhiteColor,
            ),
          ),
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Booking(),
                ),
              );
              _refresh();
            },
            icon: Icon(
              Icons.bar_chart,
              color: kWhiteColor,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(
                left: 16, right: 16, top: 16, bottom: 150),
            children: [
              Text(
                "Booking Event",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: size18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 6,
                  left: 4,
                  top: 20,
                ),
                child: Text(
                  "Activites",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                      border: Border.all(
                        width: kBorderWidth,
                        color: kBorderColor,
                      ),
                    ),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                      elevation: 1,
                      isExpanded: false,
                      hint: const Text(
                        "Select Activities",
                        style: TextStyle(
                          fontSize: size14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      value: savedModel.bookingType,
                      items: listData.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (onVal) {
                        savedModel.bookingType = onVal;
                        if (startTimeController.text.isNotEmpty &&
                            endTimeController.text.isNotEmpty &&
                            savedModel.date != null) {
                          savedModel.difference = Helper.timeDifference(
                            s: startTimeController.text,
                            e: endTimeController.text,
                            dateTime: savedModel.date,
                            context: context,
                          );
                          if (savedModel.difference != null &&
                              savedModel.bookingType != null) {
                            total = Helper.calculateTotal(savedModel);
                          }
                        }
                        _notify();
                      },
                    ),
                  ),
                ),
              ),
              TextFieldWidget(
                controller: dateController,
                fn: fn,
                hintText: "Select booking date",
                labelText: "Booking Date",
                enabled: false,
                iconData: Icons.date_range_outlined,
                info: Icons.info,
                onInfoTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogBox.dialogSlot();
                    },
                  );
                },
                onTap: () async {
                  savedModel.date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                  );
                  if (savedModel.date != null &&
                      Helper.dateFormmatHelper(savedModel.date!) != null) {
                    dateController.text =
                        Helper.dateFormmatHelper(savedModel.date!)!;

                    if (startTimeController.text.isNotEmpty &&
                        endTimeController.text.isNotEmpty) {
                      savedModel.difference = Helper.timeDifference(
                        s: startTimeController.text,
                        e: endTimeController.text,
                        dateTime: savedModel.date,
                        context: context,
                      );
                      if (savedModel.difference != null &&
                          savedModel.bookingType != null) {
                        total = Helper.calculateTotal(savedModel);
                      }
                    }
                  }
                  _notify();
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: startTimeController,
                      fn: startfn,
                      hintText: "Select time",
                      labelText: "Start Time",
                      enabled: false,
                      iconData: Icons.timer_outlined,
                      onTap: () async {
                        if (dateController.text.isEmpty) {
                          Helper.toast(context, "Select booking date");
                        } else {
                          TimeOfDay? time =
                              await Helper.getTime(context, savedModel.date!);

                          if (time != null &&
                              Helper.timeFormmatHelper(context, time) != null) {
                            savedModel.startTime = time;
                            savedModel.formatedStartTime =
                                Helper.timeFormmatHelper(context, time);

                            startTimeController.text =
                                savedModel.formatedStartTime ?? "";
                            isSelectedTimeSlots2 = false;
                            isSelectedTimeSlots = false;

                            if (startTimeController.text.isNotEmpty &&
                                endTimeController.text.isNotEmpty &&
                                savedModel.date != null) {
                              savedModel.difference = Helper.timeDifference(
                                s: startTimeController.text,
                                e: endTimeController.text,
                                dateTime: savedModel.date,
                                context: context,
                              );
                              if (savedModel.difference != null &&
                                  savedModel.bookingType != null) {
                                total = Helper.calculateTotal(savedModel);
                              }
                            }
                          }
                        }
                        _notify();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFieldWidget(
                      controller: endTimeController,
                      fn: endfn,
                      hintText: "Select time",
                      labelText: "End Time",
                      enabled: false,
                      iconData: Icons.timer_outlined,
                      onTap: () async {
                        if (dateController.text.isEmpty) {
                          Helper.toast(context, "Select booking date");
                        } else {
                          TimeOfDay? endtime =
                              await Helper.getTime(context, savedModel.date!);

                          if (endtime != null &&
                              Helper.timeFormmatHelper(context, endtime) !=
                                  null) {
                            savedModel.endTime = endtime;
                            savedModel.formatedEndTime =
                                Helper.timeFormmatHelper(context, endtime);

                            endTimeController.text =
                                savedModel.formatedEndTime ?? "";
                            isSelectedTimeSlots2 = false;
                            isSelectedTimeSlots = false;
                            if (startTimeController.text.isNotEmpty &&
                                endTimeController.text.isNotEmpty &&
                                savedModel.date != null) {
                              savedModel.difference = Helper.timeDifference(
                                s: startTimeController.text,
                                e: endTimeController.text,
                                dateTime: savedModel.date,
                                context: context,
                              );
                              if (savedModel.difference != null &&
                                  savedModel.bookingType != null) {
                                total = Helper.calculateTotal(savedModel);
                              }
                            }
                          }
                        }
                        _notify();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: TimeSlotsWidget(
                    onTap: () {
                      isSelectedTimeSlots2 = false;
                      isSelectedTimeSlots = !isSelectedTimeSlots;
                      startTimeController.clear();
                      endTimeController.clear();
                      if (isSelectedTimeSlots) {
                        startTimeController.text = SlotsEnum.morning.startTime;
                        endTimeController.text = SlotsEnum.morning.endTime;
                        savedModel.startTime =
                            SlotsEnum.morning.startTimeTimeOfDay;
                        savedModel.endTime = SlotsEnum.morning.endTimeTimeOfDay;
                        savedModel.difference = Helper.timeDifference(
                          s: startTimeController.text,
                          e: endTimeController.text,
                          dateTime: savedModel.date,
                          context: context,
                        );
                        if (savedModel.difference != null &&
                            savedModel.bookingType != null) {
                          total = Helper.calculateTotal(savedModel);
                        }
                      }
                      _notify();
                    },
                    slotsEnum: SlotsEnum.morning,
                    isSelected: isSelectedTimeSlots,
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: TimeSlotsWidget(
                    onTap: () {
                      isSelectedTimeSlots = false;

                      isSelectedTimeSlots2 = !isSelectedTimeSlots2;
                      startTimeController.clear();
                      endTimeController.clear();
                      if (isSelectedTimeSlots2) {
                        startTimeController.text = SlotsEnum.night.startTime;
                        endTimeController.text = SlotsEnum.night.endTime;
                        savedModel.startTime =
                            SlotsEnum.night.startTimeTimeOfDay;
                        savedModel.endTime = SlotsEnum.night.endTimeTimeOfDay;
                        savedModel.difference = Helper.timeDifference(
                          s: startTimeController.text,
                          e: endTimeController.text,
                          dateTime: savedModel.date,
                          context: context,
                        );
                        if (savedModel.difference != null &&
                            savedModel.bookingType != null) {
                          total = Helper.calculateTotal(savedModel);
                        }
                      }

                      _notify();
                    },
                    slotsEnum: SlotsEnum.night,
                    isSelected: isSelectedTimeSlots2,
                  )),
                ],
              ),
              TextFieldWidget(
                controller: descController,
                fn: descfn,
                hintText: "Write description(Optional)",
                labelText: "Description",
                maxLines: 4,
                minLines: 3,
              ),
              if (startTimeController.text.isNotEmpty &&
                  endTimeController.text.isNotEmpty &&
                  dateController.text.isNotEmpty &&
                  savedModel.bookingType != null)
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    color: kLightGreenColor.withOpacity(0.2),
                    border: Border.all(
                        width: kBorderWidth, color: kLightGreenColor),
                  ),
                  child: Column(
                    children: [
                      TotalCardWidget(
                        v1: "Activities",
                        v2: savedModel.bookingType ?? "",
                      ),
                      Divider(
                        height: 0,
                        color: kLightGreenColor,
                        thickness: kBorderWidth,
                      ),
                      TotalCardWidget(
                        v1: "Date",
                        v2: dateController.text,
                      ),
                      Divider(
                        height: 0,
                        color: kLightGreenColor,
                        thickness: kBorderWidth,
                      ),
                      TotalCardWidget(
                        v1: "Time",
                        v2: "${startTimeController.text} - ${endTimeController.text} (${savedModel.difference} hr)",
                      ),
                      if (savedModel.difference != null && total != null)
                        TotalCardWidget(
                          color: kLightGreenColor,
                          v1: "Total",
                          v2: "${savedModel.difference} hr x ${total! / savedModel.difference!} = $total Rs",
                        ),
                    ],
                  ),
                ),
            ],
          ),
          if (isLoading) Helper.progress()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _refresh();
        },
        child: const Icon(Icons.refresh),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                calculated ? kLightGreenColor : kPrimaryColor),
          ),
          onPressed: () async {
            validate(context);
            if (calculated) {
              saveData();
            }
          },
          child: Text(
            calculated ? "Submit" : "Calculate",
            style: TextStyle(color: kWhiteColor),
          ),
        ),
      ),
    );
  }

  bool validateTimes() {
    if (startTimeController.text.isEmpty) {
      Helper.toast(context, "Select start time");
    } else if (endTimeController.text.isEmpty) {
      Helper.toast(context, "Select end time");
    } else if (savedModel.difference == null) {
      Helper.toast(context, "Invalid start and end time diffrence");
    } else if (savedModel.difference == 0) {
      Helper.toast(context, "Start and End time must be more then 1 hours");
      endTimeController.clear();
      startTimeController.clear();
      isSelectedTimeSlots = false;
      isSelectedTimeSlots2 = false;
    } else if (savedModel.difference! < 0) {
      Helper.toast(context, "Invalid End time difference");
      endTimeController.clear();
      startTimeController.clear();
      isSelectedTimeSlots = false;
      isSelectedTimeSlots2 = false;
    } else if (savedModel.date != null &&
        Helper.timeDateValidation(
            context: context,
            date: savedModel.date,
            time: TimeOfDay(
              hour: int.parse(startTimeController.text.trim().split(":").first),
              minute:
                  int.parse(startTimeController.text.trim().split(":").last),
            ))) {
      endTimeController.clear();
      startTimeController.clear();
      isSelectedTimeSlots = false;
      isSelectedTimeSlots2 = false;
    } else {
      return true;
    }
    return false;
  }

  validate(BuildContext context) async {
    calculated = false;
    if (savedModel.bookingType == null) {
      Helper.toast(context, "Select booking activities");
    } else if (dateController.text.isEmpty) {
      Helper.toast(context, "Select booking date");
    } else if (validateTimes()) {
      total = Helper.calculateTotal(savedModel);
      calculated = true;
    }
    _notify();
  }

  saveData() {
    try {
      _changeLoading(true);
      Future.delayed(const Duration(seconds: 3), () async {
        var uuid = const Uuid();

        DateTime dateTime = savedModel.date ?? DateTime.now();
        String fDT = DateTime(dateTime.year, dateTime.month, dateTime.day,
                savedModel.startTime!.hour, savedModel.startTime!.minute)
            .toLocal()
            .toString();
        String efDT = DateTime(dateTime.year, dateTime.month, dateTime.day,
                savedModel.endTime!.hour, savedModel.endTime!.minute)
            .toLocal()
            .toString();

        BookingModel bookingModel = BookingModel(
          uuid: uuid.v1().toString(),
          bookingType: savedModel.bookingType!,
          date: savedModel.date.toString(),
          desc: descController.text.trim(),
          difference: savedModel.difference,
          fullStartDateTime: fDT,
          fullEndDateTime: efDT,
          formatedDate: dateController.text.trim(),
          formatedEndTime: endTimeController.text.trim(),
          formatedStartTime: startTimeController.text.trim(),
          total: total,
        );

        bool saved = await LocalDataBase.saveSlots(bookingModel, context);

        _changeLoading(false);
        if (saved) {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Booking(),
            ),
          );
          _refresh();
        }
      });
    } catch (e) {
      Helper.toast(context, e.toString());
      _changeLoading(false);
    }
  }
}
