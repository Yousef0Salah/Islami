import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService instance = NotificationService._();

  NotificationService._();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const String _adhanChannel = 'adhan_channel';
  static const String _silentChannel = 'silent_channel';

  Future<void> init() async {
    // Initialize timezone database.
    tz.initializeTimeZones();

    // Get device timezone.
    final timezoneInfo = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));

    // Initialize notifications.
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const darwinSettings = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await _notifications.initialize(settings);

    // Request permissions.
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final android = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await android?.requestNotificationsPermission();

    final ios = _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    await ios?.requestPermissions(alert: true, badge: true, sound: true);
  }

  // Schedule one prayer notification.
  Future<void> schedulePrayer({
    required int id,
    required String prayerName,
    required String prayerTime,
    required bool adhanEnabled,
  }) async {
    final timeParts = prayerTime.trim().split(' ')[0].split(':');

    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Don't schedule past prayers.
    if (!scheduledDate.isAfter(now)) return;

    final channelId = adhanEnabled ? _adhanChannel : _silentChannel;

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        adhanEnabled ? 'Adhan Notifications' : 'Prayer Reminders',
        channelDescription: adhanEnabled
            ? 'Prayer notifications with Adhan sound'
            : 'Prayer notifications without Adhan',
        importance: Importance.max,
        priority: Priority.high,
        playSound: adhanEnabled,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: adhanEnabled,
      ),
    );

    await _notifications.zonedSchedule(
       id
      , 'Prayer Time',
       'It is time for $prayerName prayer',
       scheduledDate,
       details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  // Cancel one notification.
  Future<void> cancelPrayer(int id) async {
    await _notifications.cancel( id);
  }

  // Cancel all notifications.
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}
