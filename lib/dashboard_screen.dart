import 'package:fleet_monitoring/notification.dart';
import 'package:fleet_monitoring/vehicle/vehicle_input.dart';
import 'package:fleet_monitoring/vehicle/vehicle_report.dart';
import 'package:fleet_monitoring/vehicle/vehicle_service.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Notif()),
            );
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
