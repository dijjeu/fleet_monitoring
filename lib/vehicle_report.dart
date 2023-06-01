import 'package:fleet_monitoring/vehicle_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'services/service_entry.dart';
import 'vehicle_service.dart';


class VehicleReport extends StatefulWidget {

  @override
  State<VehicleReport> createState() => _VehicleReportState();
}

class _VehicleReportState extends State<VehicleReport> {

  TextEditingController odometerController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController serviceDateController = TextEditingController();
  TextEditingController serviceTimeController = TextEditingController();

  List<ServiceEntry> serviceEntry = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  'Reports',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 10),
                serviceEntry.isEmpty
                    ? Text(
                  'No reports listed yet',
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: serviceEntry.length,
                  itemBuilder: (context, index) => getRow(index),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    final ServiceEntry entry = serviceEntry[index];
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${entry.serviceType}: ${entry.serviceDate}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(entry.serviceTime),
          ],
        ),
      ),
    );
  }
}