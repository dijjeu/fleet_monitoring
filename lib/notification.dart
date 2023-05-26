import 'package:fleet_monitoring/vehicle/vehicle_input.dart';
import 'package:fleet_monitoring/vehicle/vehicle_report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login/login.dart';

class Notif extends StatelessWidget {
  const Notif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fleet Monitoring'),
      ),

      /// -- DRAWER NAVIGATION --///
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_rounded),
              title: const Text('Home',),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddVehicle()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Vehicle Reports',),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const VehicleReport()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Log out'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Notification',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 35,
              fontWeight: FontWeight.w800,
              color: Colors.pink[300],
            ),
          ),
        ],
      ),
    );
  }


}