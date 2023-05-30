import 'package:fleet_monitoring/services/battery_replace.dart';
import 'package:fleet_monitoring/services/wiper_replace.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../services/service_card.dart';
import '../services/service_entry.dart';

class VehicleService extends StatefulWidget {
  @override
  State<VehicleService> createState() => _VehicleServiceState();
}

class _VehicleServiceState extends State<VehicleService> {

  TextEditingController odometerController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController serviceDateController = TextEditingController();
  TextEditingController serviceTimeController = TextEditingController();

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
          SizedBox(
            height: 300,
            child: GridView.count(
              crossAxisCount: 3,
              children: <Widget>[
                ServiceCard(
                  title: 'Periodic Maintenance Schedule',
                  image: 'assets/images/maintenance.png',
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => serviceInput()));
                  },
                ),
                ServiceCard(
                  title: 'Wiper Blades Replacement',
                  image: 'assets/images/wiper.png',
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => serviceInput()));
                  },
                ),
                ServiceCard(
                  title: 'New Battery',
                  image: 'assets/images/car-battery.png',
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => serviceInput()));
                  },
                ),
                ServiceCard(
                  title: 'Air Filter Replacement',
                  image: 'assets/images/air-filter.png',
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => serviceInput()));
                  },
                ),
                ServiceCard(
                  title: 'Tire Replacement',
                  image: 'assets/images/tires.png',
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => serviceInput()));
                  },
                ),
                ServiceCard(
                  title: 'Tire Alignment/Balance',
                  image: 'assets/images/wheel.png',
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => serviceInput()));
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
                    : ListView.builder(
                    shrinkWrap: true,
                    itemCount: serviceEntry.length,
                    itemBuilder: (context, index) => getRow(index),
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


  Widget serviceInput() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 50),
              /// -- registration details -- ///
              Text(
                'Registration Details',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink[300],
                ),
              ),
              TextField(
                controller: odometerController,
                decoration:
                const InputDecoration(labelText: 'Odometer before service'),
              ),
              TextFormField(
                controller: serviceDateController,
                decoration: const InputDecoration(
                  labelText: 'Service Date',
                  prefixIcon: Icon(Icons.calendar_month_rounded),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101)
                  );
                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate = DateFormat('MM - dd - yyyy').format(pickedDate);
                    print(formattedDate);
                    setState(() {
                      serviceDateController.text = formattedDate;
                    });
                  } else {
                    print('Date is not selected');
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the service date.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: serviceTimeController,
                decoration: const InputDecoration(
                  labelText: 'Service Time',
                  prefixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    print(pickedTime);
                    String formattedTime = pickedTime.format(context);
                    print(formattedTime);
                    setState(() {
                      serviceTimeController.text = formattedTime;
                    });
                  } else {
                    print('Time is not selected');
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the service time.';
                  }
                  return null;
                },
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location of service'),
              ),

              /// -- text buttons -- ///
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text('Done'),
                    onPressed: () {
                      final String odometer = odometerController.text.trim();
                      final String location = locationController.text.trim();
                      final String serviceDate = serviceDateController.text.trim();
                      final String serviceTime = serviceTimeController.text.trim();

                      if (odometer.isNotEmpty &&
                          location.isNotEmpty &&
                          serviceDate.isNotEmpty &&
                          serviceTime.isNotEmpty) {
                        setState(() {
                          odometerController.text = '';
                          locationController.text = '';
                          serviceDateController.text = '';
                          serviceTimeController.text = '';

                          serviceEntry.add(ServiceEntry(
                              odometer: odometer, serviceDate: serviceDate,
                              serviceTime: serviceTime, location: location)
                          );
                        });

                        Navigator.pop(context);
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}