import 'package:fleet_monitoring/services/air_filter.dart';
import 'package:fleet_monitoring/services/battery_replace.dart';
import 'package:fleet_monitoring/services/new_tires.dart';
import 'package:fleet_monitoring/services/pms.dart';
import 'package:fleet_monitoring/services/wheel_balance.dart';
import 'package:fleet_monitoring/services/wiper_replace.dart';
import 'package:fleet_monitoring/vehicle/vehicle_input.dart';
import 'package:fleet_monitoring/vehicle/vehicle_report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../notification.dart';
import '../services/service_entry.dart';

class VehicleService extends StatelessWidget {
  VehicleService({Key? key}) : super(key: key);

  List<ServiceEntry> serviceEntry = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 50),
          Text(
            'Services',
            style: GoogleFonts.poppins(
              fontSize: 35,
              fontWeight: FontWeight.w800,
              color: Colors.pink[300],
            ),
          ),
          Text(
            'Please select a service you had undergone.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.pink[300],
            ),
          ),
          Container(
            height: 300,
            child: GridView.count(
              crossAxisCount: 3,
              children: <Widget>[
                ServiceCard(
                  title: 'Periodic Maintenance Schedule',
                  image: 'assets/images/maintenance.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PMSchedule()),
                    );
                  },
                ),
                ServiceCard(
                  title: 'Wiper Blades Replacement',
                  image: 'assets/images/wiper.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WiperReplace()),
                    );
                  },
                ),
                ServiceCard(
                  title: 'New Battery',
                  image: 'assets/images/car-battery.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BatteryReplace()),
                    );
                  },
                ),
                ServiceCard(
                  title: 'Air Filter Replacement',
                  image: 'assets/images/air-filter.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PMSchedule()),
                    );
                  },
                ),
                ServiceCard(
                  title: 'Tire Replacement',
                  image: 'assets/images/tires.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WiperReplace()),
                    );
                  },
                ),
                ServiceCard(
                  title: 'Tire Alignment/Balance',
                  image: 'assets/images/wheel.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BatteryReplace()),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  'Reports',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    color: Colors.pink[300],
                  ),
                ),
                const SizedBox(height: 10),
                serviceEntry.isEmpty
                  ? const Text('No reports listed yet')
                  : Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serviceEntry[index].serviceDate,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(serviceEntry[index].serviceTime),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(image, height: 50),
              const SizedBox(height: 8.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

