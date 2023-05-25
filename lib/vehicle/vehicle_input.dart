import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../vehicle.dart';

class VehicleInput extends StatefulWidget {
  @override
  _VehicleInputState createState() => _VehicleInputState();
}

class _VehicleInputState extends State<VehicleInput> {
  TextEditingController carMakeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController yearModelController = TextEditingController();
  TextEditingController plateNumController = TextEditingController();

  TextEditingController regisNumController = TextEditingController();
  TextEditingController orNumController = TextEditingController();
  TextEditingController regisDateController = TextEditingController();
  TextEditingController orDateIssuedController = TextEditingController();

  List<VehicleDetails> vehicleDetails = [];

  @override
  void initState() {
    regisDateController.text = "";
    orDateIssuedController.text = "";
    super.initState();
  }

  int selectIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// -- vehicle details input -- ///
            const SizedBox(height: 50),
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

            const SizedBox(height: 30),

            /// -- registration details input -- ///
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
              decoration: const InputDecoration(labelText: 'Registration Number'),
            ),
            TextField(
              controller: regisDateController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.calendar_month_rounded),
                labelText: 'Enter Registration Date',
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
                  String formattedDate = DateFormat('MM - dd - yyyy').format(pickedDate);
                  setState(() {
                    regisDateController.text = formattedDate;
                  });
                } else {
                  print('Date is not selected');
                }
              },
            ),
            TextField(
              controller: orNumController,
              decoration: const InputDecoration(labelText: 'OR Number'),
            ),
            TextField(
              controller: orDateIssuedController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.calendar_month_rounded),
                labelText: 'Enter OR Date issued',
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
                  String formattedDate = DateFormat('MM - dd - yyyy').format(pickedDate);
                  setState(() {
                    orDateIssuedController.text = formattedDate;
                  });
                } else {
                  print('Date is not selected');
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    DateTime currentDate = DateTime.now();

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
                      DateTime registrationDate = DateFormat('MM - dd - yyyy').parse(regisDate);

                      if (registrationDate.isBefore(currentDate)) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Registration Expired'),
                              content: const Text('The registration for this vehicle has already expired.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        setState(() {
                          carMakeController.text = '';
                          yearModelController.text = '';
                          colorController.text = '';
                          plateNumController.text = '';

                          regisNumController.text = '';
                          regisDateController.text = '';
                          orNumController.text = '';
                          orDateIssuedController.text = '';

                          vehicleDetails.add(
                            VehicleDetails(
                              carMake: carMake,
                              color: color,
                              yearModel: yearModel,
                              plateNum: plateNum,
                              regisNum: regisNum,
                              orNum: orNum,
                              regisDate: regisDate,
                              orDateIssued: orDateIssued,
                            ),
                          );
                        });
                      }
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('DONE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
