import 'package:fleet_monitoring/notification.dart';
import 'package:fleet_monitoring/utils/stored_values.dart';
import 'package:fleet_monitoring/vehicle.dart';
import 'package:fleet_monitoring/vehicle/vehicle_entry.dart';
import 'package:fleet_monitoring/vehicle/vehicle_input.dart';
import 'package:fleet_monitoring/vehicle/vehicle_report.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{

  List<VehicleDetails> vehicleDetails = List.empty(growable: true);

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
                Navigator.pop(context);
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
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Stored Users',),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StoredValuesPage()));
              },
            ),
          ],
        ),
      ),
      /// -- VEHICLE ENTRIES -- ///
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                'Vehicles',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  color: Colors.pink[300],
                ),
              ),
              vehicleDetails.isEmpty
                  ? const Text(
                'No vehicles listed yet..',
                style: TextStyle(fontSize: 22),
              ) : Expanded(
                child: ListView.builder(
                  itemCount: vehicleDetails.length,
                  itemBuilder: (context, index) => getRow(index),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleInput()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }



  Widget getRow(int index) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vehicleDetails[index].plateNum,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(vehicleDetails[index].carMake),
          ],
        ),
        trailing: SizedBox(
          width: 30,
          child: Row(
            children: [
              /// -- delete vehicle entry
              InkWell(
                  onTap: (() {
                    setState(() {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Vehicle'),
                          content: const Text('Are you sure to delete this vehicle from the list?'),
                          actions: [
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    vehicleDetails.removeAt(index);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          ],
                        );
                      });
                    });
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleEntry(vehicle: vehicleDetails[index],)));
        },
      ),
    );
  }
}
