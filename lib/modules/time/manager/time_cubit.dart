import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:islami/core/service/notification_service.dart';
import 'package:islami/core/service/prayer_settings_service.dart';
import 'package:islami/core/service/prayer_time_service.dart';
import 'package:islami/modules/time/data/model/azkar_model.dart';
import 'package:islami/modules/time/data/model/time_model.dart';
import 'package:islami/modules/data/repo/repo.dart';
import 'package:islami/modules/time/manager/time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit(this.settingsService) : super(TimeInitialState());

  //=========================Time=================

  TimeData? time;
  AllData allData = AllData(hijri: '', greg: '', weekday: '', listSalah: []);

  Repo repo = RepoImp();
  String timeNow = (DateFormat('dd-mm-yyyy').format(DateTime.now())).toString();
  Future<void> getTime({bool forceRefresh = false}) async {
    if (!forceRefresh && allData.listSalah.isNotEmpty) return;

    emit(TimeLoadingState());
    try {
      time = await repo.getTime(timeNow);
      if (isClosed) return;
      allData = AllData.getAllData(time!);
      startPrayerCountdown();
      schedulePrayerNotifications();
      emit(TimeSuccessState());
    } catch (e) {
      if (isClosed) return;
      emit(TimeErrorState(e.toString()));
    }
  }

  //===================

  final PrayerTimeService prayerTimeService = PrayerTimeService();

  final PrayerSettingsService settingsService;

  AllSalah? get nextPrayer => prayerTimeService.nextPrayer;

  String get remainingTime => prayerTimeService.formattedRemainingTime;

  void startPrayerCountdown() {
    prayerTimeService.start(
      prayers: allData.listSalah,
      onTick: () {
        if (!isClosed) {
          emit(
            TimeCountdownState(
              nextPrayer: nextPrayer!,
              remainingTime: remainingTime,
            ),
          );
        }
      },
    );
  }

  Future<void> schedulePrayerNotifications() async {
    for (int i = 0; i < allData.listSalah.length; i++) {
      final prayer = allData.listSalah[i];

      final enabled = settingsService.isNotificationEnabled(prayer.name);

      if (!enabled) {
        await NotificationService.instance.cancelPrayer(i);
        continue;
      }

      await NotificationService.instance.schedulePrayer(
        id: i,
        prayerName: prayer.name,
        prayerTime: prayer.rawTime,
        adhanEnabled: settingsService.isAdhanEnabled(prayer.name),
      );
    }
  }
}
