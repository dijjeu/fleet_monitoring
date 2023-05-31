import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

class Notif extends StatefulWidget {
  const Notif({Key? key}) : super(key: key);

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('flutter_devs');
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Notification',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 35,
              fontWeight: FontWeight.w800,
              color: Colors.pink[300],
            ),
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('Simple Notification'),
            onPressed: () {
              showNotification;
            }
          ),
        ],
      ),
    );
  }

  showNotification(String? title, String? body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        platformChannelSpecifics
    );
  }

}