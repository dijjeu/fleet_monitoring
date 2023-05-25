import 'package:fleet_monitoring/home.dart';
import 'package:fleet_monitoring/notification.dart';
import 'package:fleet_monitoring/vehicle/vehicle_report.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          DashboardCard(
            title: 'Vehicles',
            icon: Icons.directions_car,
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          DashboardCard(
            title: 'Reports',
            icon: Icons.report,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleReport()));
            },
          ),
          DashboardCard(
            title: 'Services',
            icon: Icons.build,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleReport()));
            },
          ),
          DashboardCard(
            title: 'Notifications',
            icon: Icons.notifications,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Notif()));
            },
          ),
        ],
      ),
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