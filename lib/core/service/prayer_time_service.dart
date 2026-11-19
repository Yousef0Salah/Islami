import 'dart:async';

import 'package:islami/modules/time/data/model/time_model.dart';


class PrayerTimeService {
  Timer? _timer;

  AllSalah? nextPrayer;
  DateTime? nextPrayerDateTime;

  Duration remainingTime = Duration.zero;

  void start({
    required List<AllSalah> prayers,
    required void Function() onTick,
  }) {
    _timer?.cancel();

    calculateNextPrayer(prayers);

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        calculateNextPrayer(prayers);
        onTick();
      },
    );
  }

  void calculateNextPrayer(List<AllSalah> prayers) {
    final now = DateTime.now();

    final upcomingPrayers = prayers
        .map((prayer) {
          final parts = prayer.rawTime.split(':');

          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);

          return (
            prayer: prayer,
            date: DateTime(
              now.year,
              now.month,
              now.day,
              hour,
              minute,
            ),
          );
        })
        .where((item) => item.date.isAfter(now))
        .toList();

    if (upcomingPrayers.isNotEmpty) {
      final next = upcomingPrayers.first;

      nextPrayer = next.prayer;
      nextPrayerDateTime = next.date;
    } else {
      // جميع صلوات اليوم انتهت.
      nextPrayer = prayers.first;

      final parts = prayers.first.rawTime.split(':');

      nextPrayerDateTime = DateTime(
        now.year,
        now.month,
        now.day + 1,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    }

    remainingTime = nextPrayerDateTime!.difference(now);
  }

  String get formattedRemainingTime {
    final hours = remainingTime.inHours;
    final minutes = remainingTime.inMinutes.remainder(60);
    final seconds = remainingTime.inSeconds.remainder(60);

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  void dispose() {
    _timer?.cancel();
  }
}