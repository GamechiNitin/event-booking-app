enum SlotsEnum {
  night("4:00 PM - 10:00 PM", "16:00", "22:00"),
  morning("10:00 AM - 4:00 PM", "10:00", "16:00");

  final String data;
  final String startTime;
  final String endTime;
  const SlotsEnum(this.data, this.startTime, this.endTime);
}
