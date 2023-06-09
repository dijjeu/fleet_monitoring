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

  bool get isRegistrationAlmost {
    final currentDate = DateTime.now();
    final expiryDate = DateFormat('MM/dd/yyyy').parse(widget.vehicle.regisExp);
    final reminderDate = expiryDate.subtract(const Duration(days: 30));
    return currentDate.isAfter(reminderDate) && currentDate.isBefore(expiryDate);
  }


  bool get shouldShowReminder {
    final currentDate = DateTime.now();
    final expiryDate = DateFormat('MM/dd/yyyy').parse(widget.vehicle.regisExp);
    final reminderDate = expiryDate.subtract(const Duration(days: 30));
    return currentDate.isAfter(reminderDate) && !isRegistrationExpired;
  }

  Future<void> showReminderDialog(BuildContext context) async {
    final currentDate = DateTime.now();
    final expiryDate = DateFormat('MM/dd/yyyy').parse(widget.vehicle.regisExp);
    final daysRemaining = expiryDate.difference(currentDate).inDays;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration Expiry Reminder'),
        content: Text('Your vehicle registration will expire in $daysRemaining days. Please renew as soon as possible.'),
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
                  color: Colors.black,
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
                color: Colors.blue[800],
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
                color: Colors.blue[800],
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
                      title: Text('Expired Vehicle Registration'),
                      content: Text('Please avoid using the vehicle and renew as soon as possible!'),
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
                        fontWeight:
                          isRegistrationExpired ? FontWeight.bold : FontWeight.normal,
                        color:
                          isRegistrationExpired ? Colors.red : null,
                        fontStyle:
                          isRegistrationExpired ? FontStyle.italic : FontStyle.normal,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Icon(
                      Icons.dangerous_rounded,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            if(isRegistrationAlmost)
              GestureDetector(
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text('Expiring Vehicle Registration'),
                      content: Text('Your vehicle registration is about to expire. Please renew as soon as possible!'),
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
                        fontWeight:
                        isRegistrationAlmost ? FontWeight.bold : FontWeight.normal,
                        color:
                        isRegistrationAlmost ? Colors.orange : null,
                        fontStyle:
                        isRegistrationAlmost ? FontStyle.italic : FontStyle.normal,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Icon(
                      Icons.warning,
                      color: Colors.orange,
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
