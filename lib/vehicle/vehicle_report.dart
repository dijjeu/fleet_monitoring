import 'package:fleet_monitoring/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login/login.dart';
import '../notification.dart';

class VehicleReport extends StatelessWidget {
  const VehicleReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Vehicle Reports & Maintenance'),
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
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text('Vehicle Reports'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Notif()));
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
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select a service.',
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.pink[300],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(10),
                    children: [
                      ListTile(
                        leading: Image.asset('assets/images/car-oil.png', scale: 12),
                        title: const Text('Oil Change'),
                        onTap: () {
                          Navigator.pop(context);
                        },

                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Image.asset('assets/images/wiper.png', scale: 12),
                        title: const Text('Wiper Blades Replacement'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Image.asset('assets/images/air-filter.png', scale: 12),
                        title: const Text('Replace Air Filter'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Image.asset('assets/images/maintenance.png', scale: 12),
                        title: const Text('Preventive Maintenance Schedule'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Image.asset('assets/images/tires.png', scale: 12),
                        title: const Text('New Tires'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Image.asset('assets/images/car-battery.png', scale: 12),
                        title: const Text('Battery Replacement'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Image.asset('assets/images/brake-disc.png', scale: 12),
                        title: const Text('Brake Check-up'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Image.asset('assets/images/car-engine.png', scale: 12),
                        title: const Text('Engine Tune Up'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Image.asset('assets/images/wheel.png', scale: 12),
                        title: const Text('Wheel Alignment/Balance'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Image.asset('assets/images/more.png', scale: 12),
                        title: const Text('Others'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
