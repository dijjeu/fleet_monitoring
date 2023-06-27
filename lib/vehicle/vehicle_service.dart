import 'package:file_picker/file_picker.dart';
import 'package:fleet_monitoring/repositories/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import '../repositories/app_state.dart';
import '../services/service_card.dart';
import '../repositories/service_entry.dart';

class VehicleService extends StatefulWidget {
  final List<VehicleDetails> vehicleDetails;

  VehicleService({Key? key, required this.vehicleDetails}) : super(key: key);

  @override
  State<VehicleService> createState() => _VehicleServiceState();
}

class _VehicleServiceState extends State<VehicleService>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TextEditingController odometerController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController serviceDateController = TextEditingController();
  TextEditingController serviceTimeController = TextEditingController();

  bool appointmentSet = false;
  DateTime appointmentDate = DateTime.now().add(Duration(days: 7));
  bool showAppointmentCard = true; // Set this variable to true to show the appointment card

  VehicleDetails? selectedVehicle;
  String selectedPlateNumber = '';
  List<ServiceEntry> serviceEntry = [];
  List<String> appointmentNotification = [];
  late String plateNumber = '';
  late String? selectedFilePath;


  /// --- APPOINTMENT --- ///


  @override
  void initState() {
    super.initState();
    Provider.of<AppState>(context, listen: false).setServiceEntries(serviceEntry);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              padding: EdgeInsets.only(top: 40),
              indicatorColor: Colors.red[400],
              indicatorWeight: 3,
              tabs: [
                Tab(
                  child: Text(
                    'Services',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                Tab(
                  child: Text(
                    'Reports',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  buildServicesTab(),
                  buildReportsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildServicesTab() {
    List<Widget> serviceCards = [
      ServiceCard(
        title: 'Periodic Maintenance Schedule',
        image: 'assets/images/maintenance.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  serviceInput('Periodic Maintenance Schedule'),
            ),
          );
        },
      ),
      ServiceCard(
        title: 'Wiper Blades Replacement',
        image: 'assets/images/wiper.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => serviceInput('Wiper Blades Replacement'),
            ),
          );
        },
      ),
      ServiceCard(
        title: 'New Battery',
        image: 'assets/images/car-battery.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => serviceInput('New Battery'),
            ),
          );
        },
      ),
      ServiceCard(
        title: 'Air Filter Replacement',
        image: 'assets/images/air-filter.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => serviceInput('Air Filter Replacement'),
            ),
          );
        },
      ),
      ServiceCard(
        title: 'Tire Replacement',
        image: 'assets/images/tires.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => serviceInput('Tire Replacement'),
            ),
          );
        },
      ),
      ServiceCard(
        title: 'Tire Alignment/Balance',
        image: 'assets/images/wheel.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => serviceInput('Tire Alignment/Balance'),
            ),
          );
        },
      ),
    ];

    if (!appointmentSet) {
      serviceCards.add(
        ServiceCard(
          title: 'Appointments',
          image: 'assets/images/appointment.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => appointmentForm((submitted) {
                  setState(() {
                    appointmentSet = submitted;
                  });
                }),
              ),
            );
          },
        ),
      );
    }

    serviceCards.addAll([
      ServiceCard(
        title: 'Repairs',
        image: 'assets/images/repair.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => serviceInput('Repairs'),
            ),
          );
        },
      ),
      ServiceCard(
        title: 'Others',
        image: 'assets/images/more.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => serviceInput('Others'),
            ),
          );
        },
      ),
    ]);

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
              children: serviceCards,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReportsTab() {
    if (selectedVehicle != null) {
      selectedPlateNumber = selectedVehicle!.plateNum;
    }
    return SingleChildScrollView(
      child: Column(
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
            itemBuilder: (context, index) =>
                getRow(index, serviceEntry[index].plateNumber),
          ),
        ],
      ),
    );
  }




  void showServiceDialog(
      String odometer,
      String serviceDate,
      String serviceTime,
      String location,
      String plateNumber,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              // display selected vehicle plate number
              selectedVehicle?.plateNum ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Colors.blue[800],
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mileage before service:'),
              Center(child: Text('$odometer km', style: TextStyle(fontWeight: FontWeight.bold),)),
              Text('Service Date:'),
              Center(child: Text('$serviceDate', style: TextStyle(fontWeight: FontWeight.bold),)),
              Text('Service Time:'),
              Center(child: Text('$serviceTime', style: TextStyle(fontWeight: FontWeight.bold),)),
              Text('Location of Service:'),
              Center(child: Text('$location', style: TextStyle(fontWeight: FontWeight.bold),)),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedFilePath != null) {
                      OpenFile.open(selectedFilePath!);
                    } else if(selectedFilePath == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No receipt available'),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.remove_red_eye, color: Colors.black54,),
                      const SizedBox(width: 10),
                      Text(
                        'View Receipt',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade300),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Adjust the value to control the roundness
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Back'),
              ),
            ),
          ],
        );
      },
    );
  }


  Future<void> _openFileExplorer() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result != null) {
        String? filePath = result.files.single.path;
        if (filePath != null) {
          setState(() {
            selectedFilePath = filePath;
            OpenFile.open(filePath);
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('File Selected'),
                content: Text('The file has been successfully selected.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while selecting the file.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  Widget getRow(int index, String plateNumber) {
    final ServiceEntry entry = serviceEntry[index];
    if (entry.serviceType == 'Appointments') {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => appointmentForm((submitted) => null)));
        },
        child: Card(
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$plateNumber', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Appointment'),
                Text('${entry.serviceDate} - ${entry.serviceTime}'),
              ],
            ),
            trailing: Icon(Icons.arrow_circle_right_outlined),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          showServiceDialog(
            entry.odometer,
            entry.serviceDate,
            entry.serviceTime,
            entry.location,
            plateNumber,
          );
        },
        child: Card(
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plateNumber,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${entry.serviceType}'),
                Text('${entry.serviceDate} - ${entry.serviceTime}'),
              ],
            ),
            trailing: Icon(Icons.arrow_circle_right_outlined),
          ),
        ),
      );
    }
  }


  Widget appointmentForm(Null Function(dynamic submitted) param0) {
    final appState = Provider.of<AppState>(context);
    VehicleDetails? selectedVehicle;

    if (appState.vehicleDetails.isNotEmpty) {
      selectedVehicle = appState.vehicleDetails[0];
      selectedPlateNumber = selectedVehicle.plateNum;
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 60),
              Text(
                'Appointment',
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

              /// -- vehicle dropdown -- ///
              DropdownButtonFormField<VehicleDetails>(
                key: Key(selectedVehicle?.plateNum ?? ''),
                value: selectedVehicle,
                items: appState.vehicleDetails.map((vehicle) {
                  return DropdownMenuItem<VehicleDetails>(
                    value: vehicle,
                    child: Text(vehicle.plateNum),
                  );
                }).toList(),
                onChanged: (VehicleDetails? newValue) {
                  setState(() {
                    selectedVehicle = newValue;
                    selectedPlateNumber = newValue?.plateNum ?? '';
                    print('This is newValue: ${selectedVehicle?.plateNum}');
                  });
                },
                onSaved: (VehicleDetails? newValue) {
                  setState(() {
                    selectedVehicle = newValue;
                    selectedPlateNumber = newValue?.plateNum ?? '';
                    print('This is newValue: ${selectedVehicle?.plateNum}');
                  });
                },
              ),

              /// -- service details -- ///
              TextField(
                controller: odometerController,
                decoration: const InputDecoration(
                  labelText: 'Mileage before service',
                ),
                maxLength: 5,
                keyboardType: TextInputType.number,
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
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                    DateFormat('MM/dd/yyyy').format(pickedDate);
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
                decoration: const InputDecoration(
                  labelText: 'Location of service',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  _openFileExplorer();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.upload, color: Colors.black54,),
                    const SizedBox(width: 10),
                    Text(
                      'Upload Receipt',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade300),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the value to control the roundness
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// -- text buttons -- ///
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
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
                            serviceType: 'Appointment',
                            odometer: odometer,
                            serviceDate: serviceDate,
                            serviceTime: serviceTime,
                            location: location,
                            plateNumber: selectedPlateNumber, // Store the selected plate number in the service entry
                          ));
                        });
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget serviceInput(String serviceType) {
    final appState = Provider.of<AppState>(context);
    if (selectedVehicle != null) {
      selectedPlateNumber = selectedVehicle!.plateNum;
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

              /// -- vehicle dropdown -- ///
              DropdownButtonFormField<VehicleDetails>(
                key: Key(selectedVehicle?.plateNum ?? ''),
                value: selectedVehicle,
                items: appState.vehicleDetails.map((vehicle) {
                  return DropdownMenuItem<VehicleDetails>(
                    value: vehicle,
                    child: Text(vehicle.plateNum),
                  );
                }).toList(),
                onChanged: (VehicleDetails? newValue) {
                  setState(() {
                    selectedVehicle = newValue;
                    selectedPlateNumber = newValue?.plateNum ?? '';
                    print('This is newValue: ${selectedVehicle?.plateNum}');
                  });
                },
                onSaved: (VehicleDetails? newValue) {
                  setState(() {
                    selectedVehicle = newValue;
                    selectedPlateNumber = newValue?.plateNum ?? '';
                    print('This is newValue: ${selectedVehicle?.plateNum}');
                  });
                },
                hint: Text(selectedVehicle?.plateNum ?? 'Select a vehicle'),
              ),

              /// -- service details -- ///

              TextField(
                controller: odometerController,
                decoration: const InputDecoration(
                  labelText: 'Mileage before service',
                ),
                maxLength: 5,
                keyboardType: TextInputType.number,
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
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('MM/dd/yyyy').format(pickedDate);
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
                decoration: const InputDecoration(
                  labelText: 'Location of service',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  _openFileExplorer();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.upload, color: Colors.black54,),
                    const SizedBox(width: 10),
                    Text(
                        'Upload Receipt',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade300),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the value to control the roundness
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// -- text buttons -- ///
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
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
                          plateNumber = '';

                          serviceEntry.add(ServiceEntry(
                            serviceType: serviceType,
                            odometer: odometer,
                            serviceDate: serviceDate,
                            serviceTime: serviceTime,
                            location: location,
                            plateNumber: selectedPlateNumber, // Store the selected plate number in the service entry
                          ));
                        });
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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