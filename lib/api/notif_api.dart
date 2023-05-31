import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('traffic');

    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification({String? title, String? body}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await notificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
