part of 'booking_bloc.dart';

@immutable
abstract class BookingState {}

abstract class BookingActionState extends BookingState {}

// Initial State
class BookingInitial extends BookingState {}

// Build State
class BookingLoadingState extends BookingState {}

class BookingLoadedSuccessState extends BookingState {
  final List<BookingModel> bookingList;
  BookingLoadedSuccessState({required this.bookingList});
}

class BookingErrorState extends BookingState {}

class BookingNavigateToStarPageActionState extends BookingActionState {}

class BookingStarAddedState extends BookingActionState {}
