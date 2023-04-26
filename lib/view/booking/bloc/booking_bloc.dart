import 'dart:async';
import 'dart:developer';

import 'package:adda/db/local/local_database.dart';
import 'package:adda/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<BookingInitialEvent>(homeInitialEvent);
    on<HomeProductStarOnClickedEvent>(homeProductStarOnClickedEvent);
    on<HomeStarOnTapNavigateEvent>(homeCartOnTapNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
    BookingInitialEvent event,
    Emitter<BookingState> emit,
  ) async {
    try {
      emit(BookingLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      List<BookingModel> dataList = await LocalDataBase.getSaveSlots();
      emit(BookingLoadedSuccessState(bookingList: dataList));
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> homeProductStarOnClickedEvent(
      HomeProductStarOnClickedEvent event, Emitter<BookingState> emit) {
    // starList.add(event.clickedProduct);
    emit(BookingStarAddedState());
  }

  FutureOr<void> homeCartOnTapNavigateEvent(
      HomeStarOnTapNavigateEvent event, Emitter<BookingState> emit) {
    log("homeCartOnTapNavigateEvent");
    emit(BookingNavigateToStarPageActionState());
  }
}
