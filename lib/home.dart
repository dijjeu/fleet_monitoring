import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fleet_monitoring/auth/auth.dart';
import 'package:fleet_monitoring/dashboard_screen.dart';
import 'package:fleet_monitoring/notification.dart';
import 'package:fleet_monitoring/profile_screen.dart';
import 'package:fleet_monitoring/repositories/service_entry.dart';
import 'package:fleet_monitoring/repositories/user_repository.dart';
import 'package:fleet_monitoring/vehicle_report.dart';
import 'package:fleet_monitoring/vehicle_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int _currentIndex = 0;

  final pages = [
    DashboardScreen(),
    NotificationScreen(payload),
    ProfileScreen(userRepository: UserRepository(
        firstName: '', lastName: '', phoneNumber: '', licenseNumber: '', licenseExpiry: ''
    )),
  ];


  static String? get payload => null;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home_rounded), //home
      const Icon(Icons.notifications), //notification
      const Icon(Icons.person_rounded), //vehicle report
    ];

    return Scaffold(
      extendBody: false,
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
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
