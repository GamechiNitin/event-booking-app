part of 'booking_bloc.dart';

@immutable
abstract class BookingEvent {}

class BookingInitialEvent extends BookingEvent {}

class HomeProductStarOnClickedEvent extends BookingEvent {
  final BookingModel clickedProduct;
  HomeProductStarOnClickedEvent(this.clickedProduct);
}

class HomeStarOnTapNavigateEvent extends BookingEvent {}
