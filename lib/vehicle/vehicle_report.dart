import 'package:fleet_monitoring/vehicle/vehicle_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/service_entry.dart';

class VehicleReport extends StatelessWidget {
  final List<ServiceEntry> serviceEntry;

  const VehicleReport({
    Key? key, required this.serviceEntry
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text(
              'Vehicle Reports',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 35,
                fontWeight: FontWeight.w800,
                color: Colors.pink[300],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: serviceEntry.length,
                itemBuilder: (context, index) {
                  final entry = serviceEntry[index];
                  return Card(
                    child: ListTile(
                      title: Text('Odometer Reading: ${entry.odometer}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service Date: ${entry.serviceDate}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Service Time: ${entry.serviceTime}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Location: ${entry.location}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
