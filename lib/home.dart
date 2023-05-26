import 'package:fleet_monitoring/dashboard_screen.dart';
import 'package:fleet_monitoring/notification.dart';
import 'package:fleet_monitoring/vehicle/vehicle_input.dart';
import 'package:fleet_monitoring/vehicle/vehicle_report.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const AddVehicle(),
    const Notif(),
    const VehicleReport(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 34),
          decoration: BoxDecoration(
            color: Colors.blue[800],
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                color: _currentIndex == 0 ? Colors.red[400] : Colors.white,
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.directions_car),
                color: _currentIndex == 1 ? Colors.red[400] : Colors.white,
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                color: _currentIndex == 2 ? Colors.red[400] : Colors.white,
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.person),
                color: _currentIndex == 3 ? Colors.red[400] : Colors.white,
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),

    );
  }


  Widget _dashboard (BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        DashboardCard(
          title: 'Vehicles',
          icon: Icons.directions_car,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddVehicle()));
          },
        ),
        DashboardCard(
          title: 'Reports',
          icon: Icons.report,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const VehicleReport()));
          },
        ),
        DashboardCard(
          title: 'Services',
          icon: Icons.build,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const VehicleReport()));
          },
        ),
        DashboardCard(
          title: 'Notifications',
          icon: Icons.notifications,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Notif()));
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