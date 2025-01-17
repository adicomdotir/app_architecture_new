import 'package:freezed_annotation/freezed_annotation.dart';

import '../activity/activity.dart';
import '../destination/destination.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

@freezed
class Booking with _$Booking {
  const factory Booking({
    /// Start date of the trip
    required DateTime startDate,

    /// End date of the trip
    required DateTime endDate,

    /// Destination of the trip
    required Destination destination,

    /// List of chosen activities
    required List<Activity> activity,

    /// Optional ID of the booking.
    /// May be null if the booking is not yet stored.
    int? id,
  }) = _Booking;

  factory Booking.fromJson(Map<String, Object?> json) =>
      _$BookingFromJson(json);
}
