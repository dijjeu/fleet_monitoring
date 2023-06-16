import 'package:fleet_monitoring/login/login.dart';
import 'package:fleet_monitoring/repositories/app_state.dart';
import 'package:fleet_monitoring/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserRepository? userData = Provider.of<AppState>(context).userData;
    String? licenseExpiryString = userData?.licenseExpiry;
    DateTime? licenseExpiryDate;
    bool isLicenseAlmost = false;
    bool isLicenseExpiring = false;

    if (licenseExpiryString != null) {
      licenseExpiryDate = DateFormat('MM/dd/yyyy').parse(licenseExpiryString);

      DateTime today = DateTime.now();
      DateTime thirtyDaysFromNow = today.add(Duration(days: 30));
      isLicenseAlmost = licenseExpiryDate.isBefore(thirtyDaysFromNow);
      isLicenseExpiring = licenseExpiryDate.year == today.year &&
          licenseExpiryDate.month == today.month &&
          licenseExpiryDate.day == today.day;
    }

    return Scaffold(
      body: userData != null
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Profile',
                      style: GoogleFonts.montserrat(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CircleAvatar(
                      child: Image.asset('assets/driver.png',
                          height: 120, width: 120),
                      radius: 80,
                      backgroundColor: Colors.blue.shade800,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${userData.firstName} ${userData.lastName}',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Phone Number: ${userData.phoneNumber}',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'License Number: ${userData.licenseNumber}',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// -- driver's license is expired
                    if (isLicenseExpiring)
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Expired Driver\'s License'),
                                  content: Text(
                                      'Your driver\'s license is expired. Please avoid driving and renew as soon as possible!'),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'License Expiry: ${licenseExpiryDate != null ? DateFormat('MM/dd/yyyy').format(licenseExpiryDate) : 'N/A'}',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontStyle:
                                    isLicenseExpiring ? FontStyle.italic : null,
                                fontWeight:
                                    isLicenseExpiring ? FontWeight.bold : null,
                                color: isLicenseExpiring ? Colors.red : null,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(Icons.warning, color: Colors.red),
                          ],
                        ),
                      )
                    else if (isLicenseAlmost)
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Expiring Driver\'s License'),
                                  content: Text(
                                      'Your driver\'s license is about to expire. Please renew as soon as possible!'),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'License Expiry: ${licenseExpiryDate != null ? DateFormat('MM/dd/yyyy').format(licenseExpiryDate) : 'N/A'}',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontStyle:
                                    isLicenseAlmost ? FontStyle.italic : null,
                                fontWeight:
                                    isLicenseAlmost ? FontWeight.bold : null,
                                color: isLicenseAlmost ? Colors.orange : null,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(Icons.warning, color: Colors.orange),
                          ],
                        ),
                      )
                    else
                      /// -- driver's license is not expired
                      Text(
                        'License Expiry: ${licenseExpiryDate != null ? DateFormat('MM/dd/yyyy').format(licenseExpiryDate) : 'N/A'}',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Logout', style: TextStyle(color: Colors.black87)),
                            const SizedBox(width: 10),
                            Icon(Icons.logout_rounded, color: Colors.black87),
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
                  ],
                ),
              ),
            )
          : const Text('No data available'),
    );
  }
}
