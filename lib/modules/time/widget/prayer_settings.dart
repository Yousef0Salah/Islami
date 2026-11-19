import 'package:flutter/material.dart';

class PrayerSettings extends StatelessWidget {
  final String prayerName;

  final bool notificationEnabled;
  final bool adhanEnabled;

  final ValueChanged<bool> onNotificationChanged;
  final ValueChanged<bool> onAdhanChanged;

  const PrayerSettings({
    super.key,
    required this.prayerName,
    required this.notificationEnabled,
    required this.adhanEnabled,
    required this.onNotificationChanged,
    required this.onAdhanChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(prayerName),

      children: [
        SwitchListTile(
          title: const Text('Prayer Notification'),
          value: notificationEnabled,
          onChanged: onNotificationChanged,
        ),

        SwitchListTile(
          title: const Text('Adhan Sound'),
          value: adhanEnabled,
          onChanged: notificationEnabled
              ? onAdhanChanged
              : null,
        ),
      ],
    );
  }
}