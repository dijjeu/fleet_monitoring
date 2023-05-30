import 'package:fleet_monitoring/services/service_entry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PMSchedule extends StatefulWidget {
  const PMSchedule({Key? key}) : super(key: key);

  @override
  State<PMSchedule> createState() => _PMScheduleState();
}

class _PMScheduleState extends State<PMSchedule> {
  TextEditingController odometerController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController serviceDateController = TextEditingController();
  TextEditingController serviceTimeController = TextEditingController();

  String _message = '';

  List<ServiceEntry> serviceEntry = [];

  Future<void> _storeService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String odometer = odometerController.text.trim();
    String location = locationController.text.trim();
    String serviceDate = serviceDateController.text.trim();
    String serviceTime = serviceTimeController.text.trim();

    if (odometer.isNotEmpty &&
        location.isNotEmpty &&
        serviceDate.isNotEmpty &&
        serviceTime.isNotEmpty) {
      String serviceKey = serviceDate + serviceTime;

      SharedPreferences userPrefs = await SharedPreferences.getInstance();
      String? loggedInUser = userPrefs.getString('loggedInUser');

      if (loggedInUser != null) {
        List<String> existingServices =
            userPrefs.getStringList(loggedInUser) ?? [];
        existingServices.add(serviceKey);
        await userPrefs.setStringList(loggedInUser, existingServices);
        await userPrefs.setStringList(serviceKey, [
          odometer,
          location,
          serviceDate,
          serviceTime,
        ]);
      }
      setState(() {
        _message = 'Vehicle successfully added!';
      });
    } else {
      setState(() {
        _message = 'Please complete all fields';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Image.asset(
                'assets/images/maintenance.png',
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 20),
              Text(
                'Preventive Maintenance Service',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.pink[300],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'If you had undergone a preventive maintenance, please fill up the details to record your service.',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 20),

              /// -- pms details -- ///
              TextField(
                controller: odometerController,
                decoration:
                const InputDecoration(labelText: 'Odometer reading before service'),
                maxLength: 6,
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
                    String formattedDate =
                    DateFormat('MM - dd - yyyy').format(pickedDate);
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
                    return 'Please enter the date of service.';
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
                decoration: const InputDecoration(labelText: 'Location of Service'),
              ),
              const SizedBox(height: 20),
              /// -- text buttons -- ///
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
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
                          serviceEntry.add(
                            ServiceEntry(
                              odometer: odometer,
                              serviceDate: serviceDate,
                              serviceTime: serviceTime,
                              location: location,
                            ),
                          );
                        });
                      }

                      odometerController.text = '';
                      locationController.text = '';
                      serviceDateController.text = '';
                      serviceTimeController.text = '';

                      _storeService();
                      Navigator.pop(context);
                    },
                    child: const Text('Submit'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
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