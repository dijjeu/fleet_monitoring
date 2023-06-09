import 'package:flutter/material.dart';
import 'repositories/service_entry.dart';

class VehicleReports extends StatelessWidget {
  final List<ServiceEntry> serviceEntry;

  VehicleReports({required this.serviceEntry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Reports'),
      ),
      body: ListView.builder(
        itemCount: serviceEntry.length,
        itemBuilder: (context, index) {
          final ServiceEntry entry = serviceEntry[index];
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
