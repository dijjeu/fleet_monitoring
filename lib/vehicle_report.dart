import 'package:flutter/material.dart';
import 'services/service_entry.dart';

class VehicleReports extends StatelessWidget {
  final List<ServiceEntry> serviceEntries;

  VehicleReports({required this.serviceEntries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Reports'),
      ),
      body: ListView.builder(
        itemCount: serviceEntries.length,
        itemBuilder: (context, index) {
          final ServiceEntry entry = serviceEntries[index];
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${entry.serviceType}: ${entry.serviceDate}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(entry.serviceTime),
              ],
            ),
          );
        },
      ),
    );
  }
}
