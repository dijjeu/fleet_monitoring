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

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  // vehicle details
  TextEditingController carMakeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController yearModelController = TextEditingController();
  TextEditingController plateNumController = TextEditingController();

  // registration details
  TextEditingController regisNumController = TextEditingController();
  TextEditingController orNumController = TextEditingController();
  TextEditingController regisDateController = TextEditingController();
  TextEditingController orDateIssuedController = TextEditingController();

  List<VehicleDetails> vehicleDetails = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fleet Monitoring'),
      ),
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
              const SizedBox(height: 10),
              vehicleDetails.isEmpty
                  ? const Text(
                      'No vehicles listed yet..',
                      style: TextStyle(fontSize: 22),
                    )
                  : Expanded(
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => vehicleInput()));
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
          width: 40,
          child: Row(
            children: [
              /*InkWell(
                onTap: () {
                  carMakeController.text = vehicleDetails[index].carMake;
                  yearModelController.text = vehicleDetails[index].yearModel;
                  colorController.text = vehicleDetails[index].color;
                  plateNumController.text = vehicleDetails[index].plateNum;

                  regisNumController.text = vehicleDetails[index].regisNum;
                  regisDateController.text = vehicleDetails[index].regisDate;
                  orNumController.text = vehicleDetails[index].orNum;
                  orDateIssuedController.text = vehicleDetails[index].orDateIssued;

                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: const Icon(Icons.edit),
              ),*/
              InkWell(
                onTap: () {
                  setState(() {
                    vehicleDetails.removeAt(index);
                  });
                },
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget vehicleInput() {
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

              /// -- vehicle details -- ///
              Text(
                'Vehicle Details',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink[300],
                ),
              ),
              TextField(
                controller: carMakeController,
                decoration: const InputDecoration(labelText: 'Car Make'),
              ),
              TextField(
                controller: yearModelController,
                decoration: const InputDecoration(labelText: 'Year Model'),
              ),
              TextField(
                controller: colorController,
                decoration: const InputDecoration(labelText: 'Color'),
              ),
              TextField(
                controller: plateNumController,
                decoration: const InputDecoration(labelText: 'Plate Number'),
              ),
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
                controller: regisNumController,
                decoration:
                    const InputDecoration(labelText: 'Registration Number'),
              ),
              TextFormField(
                controller: regisDateController,
                decoration: const InputDecoration(
                  labelText: 'Registration Date',
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
                      regisDateController.text = formattedDate;
                    });
                  } else {
                    print('Date is not selected');
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the registration date.';
                  }
                  return null;
                },
              ),
              TextField(
                controller: orNumController,
                decoration: const InputDecoration(labelText: 'OR Number'),
              ),
              TextFormField(
                controller: orDateIssuedController,
                decoration: const InputDecoration(
                  labelText: 'OR Date Issued',
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
                      orDateIssuedController.text = formattedDate;
                    });
                  } else {
                    print('Date is not selected');
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the registration date.';
                  }
                  return null;
                },
              ),

              /// -- text buttons -- ///
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text('Done'),
                    onPressed: () {
                      String carMake = carMakeController.text.trim();
                      String yearModel = yearModelController.text.trim();
                      String color = colorController.text.trim();
                      String plateNum = plateNumController.text.trim();

                      String regisNum = regisNumController.text.trim();
                      String regisDate = regisDateController.text.trim();
                      String orNum = orNumController.text.trim();
                      String orDateIssued = orDateIssuedController.text.trim();

                      if (carMake.isNotEmpty &&
                          yearModel.isNotEmpty &&
                          color.isNotEmpty &&
                          plateNum.isNotEmpty &&
                          regisNum.isNotEmpty &&
                          regisDate.isNotEmpty &&
                          orNum.isNotEmpty &&
                          orDateIssued.isNotEmpty) {
                        setState(() {
                          vehicleDetails.add(VehicleDetails(
                              carMake: carMake,
                              color: color,
                              yearModel: yearModel,
                              plateNum: plateNum,
                              regisNum: regisNum,
                              orNum: orNum,
                              regisDate: regisDate,
                              orDateIssued: orDateIssued));
                        });

                        carMakeController.text = '';
                        yearModelController.text = '';
                        colorController.text = '';
                        plateNumController.text = '';

                        regisNumController.text = '';
                        regisDateController.text = '';
                        orNumController.text = '';
                        orDateIssuedController.text = '';

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
