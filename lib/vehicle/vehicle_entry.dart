import 'package:fleet_monitoring/repositories/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleEntry extends StatefulWidget {
  final VehicleDetails vehicle;

  const VehicleEntry({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  @override
  State<VehicleEntry> createState() => _VehicleEntryState();
}

class _VehicleEntryState extends State<VehicleEntry> {

  bool get isRegistrationExpired {
    final currentDate = DateTime.now();
    final expiryDate = DateFormat('MM/dd/yyyy').parse(widget.vehicle.regisExp);
    return currentDate.isAfter(expiryDate);
  }


  bool get shouldShowReminder {
    final currentDate = DateTime.now();
    final expiryDate = DateFormat('MM/dd/yyyy').parse(widget.vehicle.regisExp);
    final reminderDate = expiryDate.subtract(const Duration(days: 30));
    return currentDate.isAfter(reminderDate) && !isRegistrationExpired;
  }

  Future<void> showReminderDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration Expiry Reminder'),
        content: const Text('Your vehicle registration will expire soon!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (shouldShowReminder) {
      Future.delayed(Duration.zero, () {
        showReminderDialog(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Text(
                'Vehicle Entry',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  color: Colors.blue[800],
                ),
              ),
            ),
            // const SizedBox(height: 20),

            /// -- VEHICLE DETAILS
            Text(
              'Vehicle Details',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.red[400],
              ),
            ),
            // const SizedBox(height: 10),
            Text(
              'Car Make: ${widget.vehicle.carMake}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Year Model: ${widget.vehicle.yearModel}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Color: ${widget.vehicle.color}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Plate Number: ${widget.vehicle.plateNum}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),

            // const SizedBox(height: 20),

            /// -- REGISTRATION DETAILS
            Text(
              'Registration Details',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.red[400],
              ),
            ),
            // const SizedBox(height: 10),
            Text(
              'Registration Number: ${widget.vehicle.regisNum}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Registration Date: ${widget.vehicle.regisDate}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            if(isRegistrationExpired)
              GestureDetector(
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      content: Text('Your vehicle registration is expired. Please renew as soon as possible!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OKAY'),
                        ),
                      ],
                    );
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Registration Expiry: ${widget.vehicle.regisExp}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: isRegistrationExpired ? FontWeight.bold: FontWeight.normal,
                        color: isRegistrationExpired ? Colors.red : null,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),

            Text(
              'OR Number: ${widget.vehicle.orNum}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'OR Date Issued: ${widget.vehicle.orDateIssued}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),

            /// -- back button
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// -- back to home -- ///
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
                /// -- edit -- ///
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
