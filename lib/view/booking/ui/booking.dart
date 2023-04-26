import 'dart:developer';

import 'package:adda/db/local/local_database.dart';
import 'package:adda/utils/color.dart';
import 'package:adda/utils/helper.dart';
import 'package:adda/utils/string.dart';
import 'package:adda/view/booking/bloc/booking_bloc.dart';
import 'package:adda/view/booking/ui/componet/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final BookingBloc bookingBloc = BookingBloc();

  @override
  void initState() {
    bookingBloc.add(BookingInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      bloc: bookingBloc,
      listenWhen: (previous, current) => current is BookingActionState,
      buildWhen: (previous, current) => current is! BookingActionState,
      listener: (context, state) {
        if (state is BookingNavigateToStarPageActionState) {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const Star(),
          //   ),
          // );
        }

        if (state is BookingStarAddedState) {
          Helper.toast(context, AppString.addStar);
        }
      },
      builder: (context, state) {
        log(state.runtimeType.toString());
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Booking"),
            actions: [
              GestureDetector(
                onTap: () {
                  LocalDataBase.clear();
                  bookingBloc.add(BookingInitialEvent());
                },
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    "Clear All",
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
              ),
            ],
          ),
          body: state.runtimeType == BookingLoadingState
              ? Helper.progress()
              : state.runtimeType == BookingErrorState
                  ? const Center(child: Text(AppString.someThingWentWrong))
                  : state.runtimeType == BookingLoadedSuccessState
                      ? (state as BookingLoadedSuccessState)
                              .bookingList
                              .isNotEmpty
                          ? ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              padding: const EdgeInsets.all(20),
                              itemCount: (state).bookingList.length,
                              itemBuilder: (context, index) {
                                return BookingCardComponent(
                                  uuid: state.bookingList[index].uuid,
                                  desc: state.bookingList[index].desc,
                                  activities:
                                      state.bookingList[index].bookingType ??
                                          "",
                                  date: state.bookingList[index].date ?? "",
                                  timeDifference:
                                      state.bookingList[index].difference,
                                  total: state.bookingList[index].total,
                                  t1: state.bookingList[index]
                                          .formatedStartTime ??
                                      "",
                                  t2: state
                                          .bookingList[index].formatedEndTime ??
                                      "",
                                );
                              },
                            )
                          : const Center(child: Text(AppString.noData))
                      : const Center(child: Text(AppString.unknownError)),
        );
      },
    );
  }
}
