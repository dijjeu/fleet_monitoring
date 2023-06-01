import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fleet_monitoring/auth/auth.dart';
import 'package:fleet_monitoring/dashboard_screen.dart';
import 'package:fleet_monitoring/notification.dart';
import 'package:fleet_monitoring/services/service_entry.dart';
import 'package:fleet_monitoring/vehicle_input.dart';
import 'package:fleet_monitoring/vehicle_report.dart';
import 'package:fleet_monitoring/vehicle_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int _currentIndex = 2;

  final pages = [
    const AddVehicle(),
    VehicleService(),
    const DashboardScreen(),
    NotificationPage(),
    VehicleReport(),
  ];

  @override
  Widget build(BuildContext context) {

    final items = <Widget>[
      const Icon(Icons.directions_car_rounded), //vehicle
      const Icon(Icons.build_rounded), // services
      const Icon(Icons.home_rounded), //home
      const Icon(Icons.notifications), //notification
      const Icon(Icons.report), //vehicle report
    ];

    return Scaffold(
      extendBody: false,
      body: pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          key: navigationKey,
          color: Colors.blue.shade800,
          buttonBackgroundColor: Colors.red.shade400,
          backgroundColor: Colors.transparent,
          height: 60.0,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          index: _currentIndex,
          items: items,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
