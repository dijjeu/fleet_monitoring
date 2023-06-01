import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  final String? payload;

  NotificationScreen(this.payload);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> notifications = [];

  @override
  void initState() {
    super.initState();
    if (widget.payload != null) {
      addNotification(widget.payload!);
    }
  }

  void addNotification(String notification) {
    setState(() {
      notifications.add(notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Notifications',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  color: Colors.blue[800],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text(notifications[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
