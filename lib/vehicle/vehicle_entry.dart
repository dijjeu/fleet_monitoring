import 'package:fleet_monitoring/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class VehicleEntry extends StatelessWidget {
  final VehicleDetails vehicle;

  const VehicleEntry({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

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
            //const SizedBox(height: 20),

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
            //const SizedBox(height: 10),
            Text(
              'Car Make: ${vehicle.carMake}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Year Model: ${vehicle.yearModel}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Color: ${vehicle.color}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Plate Number: ${vehicle.plateNum}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),

            //const SizedBox(height: 20),

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
            //const SizedBox(height: 10),
            Text(
              'Registration Number: ${vehicle.regisNum}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Registration Date: ${vehicle.regisDate}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                //color: isRegistrationExpired ? Colors.red : null,
              ),
            ),
            Text(
              'OR Number: ${vehicle.orNum}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'OR Date Issued: ${vehicle.orDateIssued}',
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
