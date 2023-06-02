import 'package:fleet_monitoring/services/battery_replace.dart';
import 'package:fleet_monitoring/services/wiper_replace.dart';
import 'package:fleet_monitoring/vehicle_report.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'services/service_card.dart';
import 'services/service_entry.dart';

class VehicleService extends StatefulWidget {
  @override
  State<VehicleService> createState() => _VehicleServiceState();
}

class _VehicleServiceState extends State<VehicleService> {
  TextEditingController odometerController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController serviceDateController = TextEditingController();
  TextEditingController serviceTimeController = TextEditingController();

  List<ServiceEntry> serviceEntry = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 50),
          Text(
            'Vehicle Services',
            style: GoogleFonts.poppins(
              fontSize: 35,
              fontWeight: FontWeight.w800,
              color: Colors.blue[800],
            ),
          ),
          Text(
            'Choose a service you had undergone.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 600,
            child: GridView.count(
              crossAxisCount: 3,
              children: <Widget>[
                ServiceCard(
                  title: 'Periodic Maintenance Schedule',
                  image: 'assets/images/maintenance.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => serviceInput('Periodic Maintenance Schedule')),
                    );
                  },
                ),
                ServiceCard(
                  title: 'Wiper Blades Replacement',
                  image: 'assets/images/wiper.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => serviceInput('Wiper Blades Replacement')),
                    );
                  },
                ),
                ServiceCard(
                  title: 'New Battery',
                  image: 'assets/images/car-battery.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => serviceInput('New Battery')),
                    );
                  },
                ),
                ServiceCard(
                  title: 'Air Filter Replacement',
                  image: 'assets/images/air-filter.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => serviceInput('Air Filter Replacement')),
                    );
                  },
                ),
                ServiceCard(
                  title: 'Tire Replacement',
                  image: 'assets/images/tires.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => serviceInput('Tire Replacement')),
                    );
                  },
                ),
                ServiceCard(
                  title: 'Tire Alignment/Balance',
                  image: 'assets/images/wheel.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => serviceInput('Tire Alignment/Balance')),
                    );
                  },
                ),
                ServiceCard(
                  title: 'Appointments',
                  image: 'assets/images/appointment.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => serviceInput('Appointments')),
                    );
                  },
                ),
                ServiceCard(
                  title: 'Repairs',
                  image: 'assets/images/repair.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => serviceInput('Repairs')),
                    );
                  },
                ),
                ServiceCard(
                  title: 'Others',
                  image: 'assets/images/more.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => serviceInput('Others')),
                    );
                  },
                ),
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
        ],
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


  Widget serviceInput(String serviceType) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 60),
              Text(
                serviceType,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Please fill up the form below completely and accurately.',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              /// -- service details -- ///
              TextField(
                controller: odometerController,
                decoration: const InputDecoration(labelText: 'Mileage before service'),
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
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
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
              const SizedBox(height: 20),

              /// -- text buttons -- ///
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.red[400],
                      ),
                    ),
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
                            serviceType: serviceType,
                            odometer: odometer,
                            serviceDate: serviceDate,
                            serviceTime: serviceTime,
                            location: location,
                          ));
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VehicleReports(serviceEntries: serviceEntry),
                          ),
                        );
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
