import 'package:fleet_monitoring/notification.dart';
import 'package:fleet_monitoring/vehicle_input.dart';
import 'package:fleet_monitoring/vehicle_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void onDidReceiveNotificationResponse(
      String? payload, BuildContext context) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
      await Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => NotificationScreen(payload)),
      );
    }
  }

  Future<void> _showNotification(String title, String message) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, title, message, notificationDetails,
        payload: 'item x');
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        DashboardCard(
          title: 'Vehicles',
          icon: Icons.directions_car,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddVehicle()),
            );
          },
        ),
        DashboardCard(
          title: 'Services',
          icon: Icons.build,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VehicleService()),
            );
          },
        ),
        DashboardCard(
          title: 'Notifications',
          icon: Icons.notifications,
          onTap: () {
            final payload = 'This is a sample payload';
            _showNotification('Hello', 'This is a sample notification');
            onDidReceiveNotificationResponse(payload, context);
          },
        ),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 64.0),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
