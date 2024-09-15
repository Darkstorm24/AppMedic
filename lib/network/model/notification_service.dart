import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('pill'); // Ensure 'pill' icon is added

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledDate,
      {bool soundAlarm = true}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics;

    if (soundAlarm) {
      try {
        androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'default_channel_id', // Default channel ID
          'Default Channel', // Default channel name
          //'Default Channel for Medication Reminders', // Default channel description
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('notification_sound'), // Ensure 'notification_sound' file is added
        );
      } catch (e) {
        androidPlatformChannelSpecifics = const AndroidNotificationDetails(
          'default_channel_id',
          'Default Channel',
          //'Default Channel for Medication Reminders',
          importance: Importance.max,
          priority: Priority.high,
        );
        print('Notification sound file not found: $e');
      }
    } else {
      androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'default_channel_id',
        'Default Channel',
        //'Default Channel for Medication Reminders',
        importance: Importance.max,
        priority: Priority.high,
      );
    }

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Initialize timezone data
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Ensures daily repeat
    );
  }
}
