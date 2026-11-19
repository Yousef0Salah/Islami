import 'package:shared_preferences/shared_preferences.dart';

class PrayerSettingsService {
  PrayerSettingsService._();
  static final PrayerSettingsService instance = PrayerSettingsService._();

  late SharedPreferences _prefs;

  void init(SharedPreferences prefs) => _prefs = prefs;

  bool isNotificationEnabled(String prayer) =>
      _prefs.getBool('notification_$prayer') ?? true;

  bool isAdhanEnabled(String prayer) =>
      _prefs.getBool('adhan_$prayer') ?? true;

  Future<void> setNotificationEnabled(String prayer, bool enabled) async =>
      _prefs.setBool('notification_$prayer', enabled);

  Future<void> setAdhanEnabled(String prayer, bool enabled) async =>
      _prefs.setBool('adhan_$prayer', enabled);
}